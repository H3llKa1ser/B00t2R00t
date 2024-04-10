# PowershellKerberos project

## Link: https://github.com/MzHmO/PowershellKerberos

## Tools: dumper.ps1 injector.ps1

### Usage:

#### 1) .\dumper.ps1 (Dumps Kerberos tickets from the LSA cache. If the tool is run as a privileged user, it will automatically obtain NT AUTHORITY\SYSTEM privileges and then dump all tickets. If the tool is run as a non-privileged user, it will only dump tickets from the current logon session.)

#### 2) .\injector.ps1 1 C:\path\to\ticket.kirbi (Injects kerberos tickets and reads from kirbi file)

#### 3) .\injector.ps1 2 "BASE64_TICKET" (Injects kerberos tickets and reads from base64)
