# MSOnline Powershell Module for MO365

## Commands:

### 1) Import MSOnline powershell module

    Import-Module MSOnline 

### 2) Authentication

    Connect-MsolService 

    $credential = Get-Credential

    Connect-MsolService -Credential $credential

### 3) Account and Directory Information

#### List Company Information

    Get-MSolCompanyInformation 

#### List all users

    Get-MSolUser -All 

#### List all groups

    Get-MSolGroup -All 

#### List members of a group (Global Admins in this case)

    Get-MsolRole -RoleName "Company Administrator" 

    Get-MSolGroupMember –GroupObjectId $GUID

#### List all user attributes

    Get-MSolUser -All | fl 

#### List Service Principals

    Get-MsolServicePrincipal 

### One-liner to search all Azure AD user attributes for passwords

    $users = Get-MsolUser; foreach($user in $users){$props = @();$user | Get-Member | foreach-object{$props+=$_.Name}; foreach($prop in $props){if($user.$prop -like "*password*"){Write-Output ("[*]" + $user.UserPrincipalName + "[" + $prop + "]" + " : " + $user.$prop)}}}

