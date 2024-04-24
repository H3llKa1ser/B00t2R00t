# MSOnline Powershell Module for MO365

## Commands:

 - Import-Module MSOnline (Import MSOnline powershell module)

### Authentication

 - Connect-MsolService (Authentication)

 - $credential = Get-Credential

 - Connect-MsolService -Credential $credential

### Account and Directory Information

 - Get-MSolCompanyInformation (List Company Information)

 - Get-MSolUser -All (List all users)

 - Get-MSolGroup -All (List all groups)

 - Get-MsolRole -RoleName "Company Administrator" (List members of a group (Global Admins in this case))

 - Get-MSolGroupMember –GroupObjectId $GUID

 - Get-MSolUser -All | fl (List all user attributes)

 - Get-MsolServicePrincipal (List Service Principals)

### One-liner to search all Azure AD user attributes for passwords

 - $users = Get-MsolUser; foreach($user in $users){$props = @();$user | Get-Member | foreach-object{$props+=$_.Name}; foreach($prop in $props){if($user.$prop -like "*password*"){Write-Output ("[*]" + $user.UserPrincipalName + "[" + $prop + "]" + " : " + $user.$prop)}}}

