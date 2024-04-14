# Powerview cont.

### Usage:

## 1) Get Current Domain: 

 - Get-NetDomain

## 2) Enum Other Domains: 

 - Get-NetDomain -Domain DOMAIN_NAME

## 3) Get Domain SID: 

 - Get-DomainSID

## 4) Get Domain Policy: 

 - Get-DomainPolicy

###  Will show us the policy configurations of the Domain about system access or kerberos

 - (Get-DomainPolicy)."system access"

 - (Get-DomainPolicy)."kerberos policy"

## 5) Get Domain Controlers:

 - Get-NetDomainController

 - Get-NetDomainController -Domain DOMAIN_NAME

## 6) Enumerate Domain Users:

 - Get-NetUser

 - Get-NetUser -SamAccountName USER

 - Get-NetUser | select cn

 - Get-UserProperty

### Check last password change

 - Get-UserProperty -Properties pwdlastset

### Get a specific "string" on a user's attribute

 - Find-UserField -SearchField Description -SearchTerm "wtver"

### Enumerate user logged on a machine

 - Get-NetLoggedon -ComputerName COMPUTER_NAME
   
### Enumerate Session Information for a machine

 - Get-NetSession -ComputerName COMPUTER_NAME
### Enumerate domain machines of the current/specified domain where specific users

 - Find-DomainUserLocation -Domain <DomainName> | Select-Object UserName, SessionFromName



