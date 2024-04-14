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

## 7) Enumerate Domain Computers:

 - Get-NetComputer -FullData

 - Get-DomainGroup

### Enumerate Live machines

 - Get-NetComputer -Ping

## 8) Enumerate Groups and Group Members:

 - Get-NetGroupMember -GroupName "GROUP_NAME" -Domain DOMAIN_NAME

### Enumerate the members of a specified group of the domain

 - Get-DomainGroup -Identity <GroupName> | Select-Object -ExpandProperty Member

### Returns all GPOs in a domain that modify local group memberships through Restricted 

 - Get-DomainGPOLocalGroup | Select-Object GPODisplayName, GroupName

## 9) Enumerate Shares

### Enumerate Domain Shares

 - Find-DomainShare

### Enumerate Domain Shares the current user has access

 - Find-DomainShare -CheckShareAccess

## 10) Enumerate Group Policies

 - Get-NetGPO

### Shows active Policy on specified machine

 - Get-NetGPO -ComputerName NAME_OF_THE_PC

 - Get-NetGPOGroup

### Get users that are part of a Machine's local Admin group

 - Find-GPOComputerAdmin -ComputerName COMPUTER_NAME

## 11) Enumerate OUs

 - Get-NetOU -FullData

 - Get-NetGPO -GPOname THE_GUID_OF_THE_GPO

## 12) Enumerate ACLs

### Returns the ACLs associated with the specified account

 - Get-ObjectAcl -SamAccountName ACCOUNT_NAME -ResolveGUIDs

 - Get-ObjectAcl -ADSprefix 'CN=Administrator, CN=Users' -Verbose

### Search for interesting ACEs

 - Invoke-ACLScanner -ResolveGUIDs

### Check the ACLs associated with a specified path (e.g smb share)

 - Get-PathAcl -Path "\\Path\Of\A\Share"

## 13) Enumerate Domain Trust

 - Get-NetDomainTrust

 - Get-NetDomainTrust -Domain DOMAIN_NAME

## 14) Enumerate Forest Trust

 - Get-NetForestDomain

 - Get-NetForestDomain Forest FOREST_NAME

### Domains of Forest Enumeration

 - Get-NetForestDomain

 - Get-NetForestDomain Forest FOREST_NAME

### Map the Trust of the Forest

 - Get-NetForestTrust

 - Get-NetDomainTrust -Forest FOREST_NAME

## 15) User Hunting

### Finds all machines on the current domain where the current user has local admin access

 - Find-LocalAdminAccess -Verbose

### Find local admins on all machines of the domain:

 - Invoke-EnumerateLocalAdmin -Verbose

### Find computers were a Domain Admin OR a specified user has a session

 - Invoke-UserHunter

 - Invoke-UserHunter -GroupName "RDPUsers"

 - Invoke-UserHunter -Stealth

### Confirming admin access:

 - Invoke-UserHunter -CheckAccess

## !!! Priv Esc to Domain Admin with User Hunting: I have local admin access on a machine -> A Domain Admin has a session on that machine - > I steal his token and impersonate him -> Profit!
