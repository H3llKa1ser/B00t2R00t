# Microsoft Graph Module Command Cheatsheet

## Commands:

### Authentication

 - Connect-MgGraph (Authenticate with an EntraID user in Azure)

 - Get-MgContext (General information check)

### Check the group membership of the user

 - $userid = USER_ID

 - Get-MgUserMemberOf -userid $userid | select * -ExpandProperty additionalProperties | Select-Object {$_.AdditionalProperties["displayName"]}

### Check if our current user has permission to access other Azure resources

 - $CurrentSubscriptionID = "SUBSCRIPTION_ID"

 - $OutputFormat = "table" (Set output format)

 - & az account set --subscription $CurrentSubscriptionID (Set the given subscription as the active one)

 - & az resource list -o $OutputFormat (List resources in the current subscription)

### Get the Object ID for a user

 - Get-MgUser -UserId USER.NAME@DOMAIN.CORP

### Check the assigned privileges of a user 

 - $UserId = 'USER_ID'

 - Get-MgUserMemberOf -userid $userid | select * -ExpandProperty additionalProperties | Select-Object {$_.AdditionalProperties["displayName"]}

### Check if the user has been assigned a Microsoft 365 license

 - Get-MgUserLicenseDetail -UserId "USER.NAME@DOMAIN.CORP"

### Check if the user belongs to a security group or if a directory role has been assigned to them

 - Get-MgUserMemberOf -UserId USER.NAME@DOMAIN.CORP | select * -ExpandProperty additionalProperties | Select-Object {$_.AdditionalProperties["displayName"]}
