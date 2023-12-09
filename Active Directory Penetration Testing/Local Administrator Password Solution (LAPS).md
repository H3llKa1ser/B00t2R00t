# ENUMERATION

#### dir ("C:\Program\LAPS\CSE"

### If admpwd.dll exists, then enumeration is successful.

#### 1) Get-Command *Admpwd*

#### 2) Find-AdmPwdExtendedRights -Identity *

#### 3) net groups "GROUP_THAT_HAS_ACCESS_TO_LAPS"

#### 4) Get-AdmPwdPassword -ComputerName PC_THAT_HAS_LAPS_ENABLED

## Possible tools: LAPSToolkit
