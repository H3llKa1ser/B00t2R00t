# Microsoft Graph Module Command Cheatsheet

### Commands:

#### Authentication

 - Connect-MgGraph (Authenticate with an EntraID user in Azure)

 - Get-MgContext (General information check)

#### Check the group membership of the user

 - $userid = USER_ID

 - Get-MgUserMemberOf -userid $userid | select * -ExpandProperty additionalProperties | Select-Object {$_.AdditionalProperties["displayName"]}
