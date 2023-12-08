## Requirements: Import-Module ActiveDirectory

### Commands:

#### 1) Get-ADUser -Filter 'Name -like "*name"' -server DC | Format-Table Name, SamAccountName -A

#### 2) Get-ADGroup -Identity GROUP -server DC

#### 3) Get-ADGroupMember -Identity GROUP -server DC 

#### 4) Get-ADUser -Identity NAME -server DC -properties *

#### 5) Get-ADDomain -server DC

#### 6) Get-ADObject -Filter 'badpwdCount -gt 0' -server DC (Password spray attack without locking out accounts)

#### 7) $ChangeDate= New-Object DateTime ( MM, DD, YY ) 

#### Get-ADObject -Filter 'whenChanged -gt $ChangeDate' -includeDeletedObjects -server DC

#### 8) Set-ADAccountPassword -Identity USERNAME -server DC -OldPassword (ConvertTo-SecureString - AsPlaintext "old" -force) -NewPassword (ConvertTo-SecureString -AsPlaintext "new" -force)

## BENEFITS

#### 1) Powershell > CMD in enumeration 

#### 2) Create your own CMDlets to enumerate

#### 3) Use AD-RSAT cmdlets to directly change AD Objects

#### 4) Specify server and domain to execute these commands using runas from a non-domain-joined machine

## DRAWBACKS

#### 1) Monitored more than CMD

#### 2) Install AD-RSAT or other scripts for powershell enumeration
