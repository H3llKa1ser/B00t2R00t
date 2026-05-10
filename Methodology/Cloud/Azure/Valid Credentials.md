# Valid Credentials

### 1) Authenticate

User

    az login -u USER - p PASSWORD --tenant TENANT_ID

Token-based auth

    $token = "TOKEN"
    Connect-AzAccount -AccessToken $token -AccountID "USER.NAME"

Service Principal

    az login --service-principal -u CLIENT_ID -p SECRET --tenant TENANT_ID

Service Principal (Login without accessing the subscription)

    az login --service-principal -u CLIENT_ID -p SECRET --tenant TENANT_ID --allow-no-subscriptions

Service Principal (Az PowerShell)

    $appsecret = ConvertTo-SecureString "SECRET_VALUE" -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential('SERVICE_PRINCIPAL_ID',$appsecret) 
    Connect-AzAccount -ServicePrincipal -Credential $cred -Tenant 'TENANT_ID'

Shared Access Signature token (SAS) URI. Can be used with tools for accessing Azure storage resources.

    https://STORAGE_ACCOUNT_NAME.blob.core.windows.net/?sv=2024-11-04&ss=b&srt=sco&sp=rl&se=2095-08-04T03:26:29Z&st=2025-08-02T19:11:29Z&spr=https&sig=gY%2B7YH5jQgxDXTkr9L9JzWAo4u1TWGT%2Bv9c6OmTJuHg%3D

### 2) List resources our account has access to (either read or write)

Azure CLI

    az resource list

Azure PowerShell

    Get-AzResource

## Microsoft Entra Certificate-Based Authentication (CBA)

### 1) Inspect the certificate (might require a password)

    openssl pkcs12 -in ./user.pfx -info -nokeys

### 2) Import Certificate on Linux

Open Browser Certificate Settings in Firefox, then navigate to:

    Preferences > Privacy & Security > Certificates > View Certificates

Import the Certificate

    Select the Your Certificates tab.
    Click Import and choose the user.pfx file (you might need to move the file to an accessible location)
    When prompted, enter the password for the certificate

Verify the certificate

    The certificate for USER.NAME should appear in the list

### 3) Import Certificate on Windows

Locate the user.pfx file

Start the Import Wizard

    Double-click the user.pfx file.
    The Certificate Import Wizard will launch.
    Follow the Wizard

Password Entry

    Enter password

If you get a security warning asking if you want to install the certificate, click Yes. A message should confirm that the import was successful.

Repeating the same step as before, while trying to login to the Azure portal you should see a message from certauth.login.microsoftonline.com.

### 4) Gain access in CLI using certificate-based auth

Tool: https://github.com/obikuro/Sato

Application IDs to use: https://learn.microsoft.com/en-us/power-platform/admin/apps-to-allow

1) Initiate the device code grant/flow. In this example, we will request an access token for ARM

        Invoke-Sato -GrantType "device_code" -TenantID "TENANT_ID" -PredefinedScope MaARM

2) Paste the device code URL into a browser

3) Enter the User Code from SATO

4) Authenticate using the CBA certificate imported

5) Back to the terminal, save the tokens printed as variables (we now have access!)

       $token = ACCESS_TOKEN
       $rftoken = REFRESH_TOKEN

6) Refresh tokens allow us to request access tokens for other Azure and Microsoft 365 services!

Example: Azure KeyVault access token request

        Invoke-Sato -GrantType "refresh_token" -TenantID "TENANT_ID"  -RefreshToken $rftoken -PredefinedScope KeyVault

## AzureHound

### 1) Obtain necessary tokens to use with AzureHound

Set the token as a variable

    $token = Get-AzAccessToken -ResourceURL https://graph.microsoft.com/ -AsSecureString
    
Print token

    [System.Net.NetworkCredential]::new("", $token.Token).Password

### 2) Run AzureHound using Access Tokens

    azurehound -j 'ACCESS_TOKEN' list --tenant 'TENANT_ID -o entra_output.json

### 3) Analyze data with BloodHound
    
## MFA Enablement Gap Audit

### 1) Download and install the tool FindMeAccess

    git clone https://github.com/absolomb/FindMeAccess
    pip install -r requirements.txt

### 2) Get the session token of the target user

ClientIDs Link: https://learn.microsoft.com/en-us/power-platform/admin/apps-to-allow

Use the client ID of Microsoft Azure PowerShell to authenticate to the Azure Resource Manager (ARM) API endpoint (example)

    python3 findmeaccess.py token -u USER.NAME@megacorp.com -p PASSWORD -r "https://management.azure.com" -c "d3590ed6-52b3-4102-aeff-aad2292ab01c"

Use PS5 User-Agent (example)

    python3 findmeaccess.py token -u USER.NAME@megacorp.com -p PASSWORD -r "https://management.azure.com" -c "d3590ed6-52b3-4102-aeff-aad2292ab01c" --user_agent "Mozilla/5.0 (PlayStation 5 3.03/SmartTV) AppleWebKit/605.1.15 (KHTML, like Gecko)"

## Storage Accounts

Request Storage API endpoint token

    curl -s -H "X-Identity-Header: $MSI_SECRET" "$MSI_ENDPOINT?api-version=2019-08-01&resource=https://storage.azure.com&client_id=$ENTRA_CLIENT_ID"'

Store it (YOU CAN USE THIS VIA DIRECT API CALLS TO REQUEST ANY RESOURCES RELATED TO STORAGE ACCOUNTS)

    $mistoragetoken = "STORAGE_API_TOKEN"

### 1) List storage account keys

    az storage account keys list -g RESOURCE_GROUP -n NAME

Entra-based (RBAC Auth)

    az account set --subscription SUBSCRIPTION_ID
    KEY=$(az storage account keys list -g RESOURCE_GROUP -n NAME --query '[0].value' -o tsv)

Azure PowerShell

    $storageAccount = Get-AzStorageAccount -ResourceGroupName "RESOURCE_GROUP_NAME" -Name "STORGAE_ACCOUNT_NAME"
    $ctx = $storageAccount.Context
    Get-AzStorageContainer -Context $ctx | Format-Table

Direct API calls

    $storageAccountName = "STORAGE_ACCOUNT_NAME"
    $apiVersion = "2021-04-10"
    $headers = @{
        "Authorization" = "Bearer $mitoken"
        "x-ms-version"  = $apiVersion
    }
    
    $url = "https://$storageAccountName.blob.core.windows.net/?comp=list"
    
    $response = Invoke-RestMethod -Method Get -Uri $url -Headers $headers
    $response

Direct API call (with curl)

    curl -sS -X POST \
      -H "Authorization: Bearer $token" \
      -H "Content-Type: application/json" \
      -H "Content-Length: 0" \
      "https://management.azure.com/subscriptions/SUBSCRIPTION_ID/resourceGroups/RESOURCE_GROUP_NAME/providers/Microsoft.Storage/storageAccounts/STORAGE_ACCOUNT_NAME/listKeys?api-version=2023-01-01" | jq

### 2) List containers

Azure CLI

    az storage container list --account-name STORAGE_ACCOUNT_NAME --auth-mode login -o table

Azure CLI with storage account keys

    az storage list --account-name STORAGE_ACOUNT_NAME --account-key "ACCOUNT_KEY" -o table

Azure CLI with Shared Access Signature Token (SAS)

    az storage container list --account-name STORAGE_ACCOUNT_NAME --sas-token "sv=2024-11-04&ss=b&srt=sco&sp=rl&se=2095-08-04T03:26:29Z&st=2025-08-02T19:11:29Z&spr=https&sig=gY%2B7YH5jQgxDXTkr9L9JzWAo4u1TWGT%2Bv9c6OmTJuHg%3D" --output table

Direct API Call

    $storageAccountName = "STORAGE_ACCOUNT_NAME"
    $apiVersion = "2021-04-10"
    $headers = @{
        "Authorization" = "Bearer $mistoragetoken"
        "x-ms-version"  = $apiVersion
    }
    
    $url = "https://$storageAccountName.blob.core.windows.net/?comp=list"
    
    $response = Invoke-RestMethod -Method Get -Uri $url -Headers $headers
    $response | xmllint --format -

### 3) List blobs in the container

Azure CLI

    az storage blob list --account-name STORAGE_ACCOUNT_NAME --container-name CONTAINER_NAME --auth-mode login -o table

Azure CLI detailed query enumeration

    az storage blob list --account-name STORAGE_ACOUNT_NAME --account-key ACCOUNT_KEY --container-name CONTAINER_NAME --query "[].{Name:name, Size:properties.contentLength, LastModified:properties.lastModified}" -o table

Direct API Call

    $storageAccountName = "STORAGE_ACCOUNT_NAME"
    $containerName = "CONTAINER_NAME"
    $apiVersion = "2021-04-10"
    $headers = @{
        "Authorization" = "Bearer $mistoragetoken"
        "x-ms-version"  = $apiVersion
    }
    
    $baseUri = "https://$storageAccountName.blob.core.windows.net/$containerName"
    $query = "?restype=container&comp=list"
    $url = $baseUri + $query
    
    $response = Invoke-RestMethod -Method Get -Uri $url -Headers $headers
    $response | xmllint --format -

Azure PowerShell

    $context = New-AzStorageContext -StorageAccountName STORAGE_ACCOUNT_NAME
    $containername = (Get-AzStorageContainer -Context $context -Name CONTAINER_NAME).name
    Get-AzStorageBlob -Container $containername -Context $context

### 4) Download container contents

Azure CLI

    az storage blob download --account-name STORAGE_ACCOUNT_NAME --container-name CONTAINER_NAME --name BLOB_NAME --file BLOB_NAME --auth-mode login

Azure CLI Batch download

    az storage blob download-batch --account-name STORAGE_ACCOUNT_NAME --account-key ACCOUNT_KEY -s CONTAINER_NAME -d ./DESTINATION_FOLDER

Direct API Call

    $blobName = "BLOB_NAME"
    $storageAccountName = "STORAGE_ACCOUNT_NAME"
    $containerName = "CONTAINER_NAME"
    $apiVersion = "2021-04-10"
    $headers = @{
        "Authorization" = "Bearer $mistoragetoken"
        "x-ms-version"  = $apiVersion
    }
    
    $blobUrl = "https://$storageAccountName.blob.core.windows.net/$containerName/$blobName"
    
    $destinationPath = "~/$blobName"
    
    Invoke-RestMethod -Method Get -Uri $blobUrl -Headers $headers -OutFile $destinationPath

### 5) Read container contents

Azure PowerShell

    Get-AzStorageBlobContent -Container $containerName -Blob cred.txt -Context $context

## Azure Key Vault

### 1) List vaults

    az keyvault list

### 2) List secrets

    az keyvault secret list --vault-name VAULT_NAME -o table

### 3) List keys

Azure CLI

    az keyvault key list --vault-name VAULT_NAME -o table

Azure PowerShell

    Get-AzKeyVaultKey -VaultName VAULT_NAME

### 3) Perform decryption

Encode our downloaded content to base64

    base64 < BLOB_NAME | tr -d '\n' > BASE64_ENCODED_BLOB

Decrypt by calling the vault directly using the stored key. (Azure handles the decryption and returns plaintext)

    az keyvault key decrypt --vault-name VAULT_NAME --name KEY_NAME --algorithm RSA-OAEP --value BASE64_ENCODED_BLOB --query result -o tsv | base64 -d > BLOB_PLAINTEXT

### 4) Query if the keyvault can be used for template deployment

    az keyvault show --name VAULT_NAME --query "properties.enabledForTemplateDeployment"

### 5) Get the thumbprint of a certiciate

    $cert = Get-AzKeyVaultCertificate -VaultName VAULT_NAME -CertificateName CERTIFICATE_NAME
    $cert.Thumbprint

## Resources

### 1) List Resources

Azure CLI

    az resource list

Azure PowerShell

    Get-AzResource

Direct API call 

    curl -s "https://management.azure.com/subscriptions/SUBSCRIPTION_ID/resourceGroups/RESOURCE_GROUP_NAME/resources?api-version=2021-04-01" -H "Authorization: Bearer $token" | jq

### 2) Get URL of a specific resource

    (Get-AzWebApp -ResourceGroupName "RESOURCE_GROUP_NAME" -Name "APP_NAME").DefaultHostName

## Azure Static Web App

### 1) Enumerate an Azure Static Web App

    az staticwebapp show --name STATIC_WEB_APP_NAME --resource-group RESOURCE_GROUP_NAME

### 2) Enumerate the Azure Web Static Web App settings

    az staticwebapp appsettings list --name STATIC_WEB_APP_NAME --resource-group RESOURCE_GROUP_NAME

## Azure VMs

### 1) Enumerate a specific Azure VM

    az vm show --resource-group RESOURCE_GROUP --name VM_NAME

### 2) Get the User Data values from the VM

Azure CLI

    az vm show --resource-group RESOURCE_GROUP_NAME --name VM_NAME -u --query "userData" --output tsv | base64 -d

Azure PowerShell

    (Get-AzVM -ResourceGroupName "RESOURCE_NAME" -Name "VM_NAME" -UserData).UserData | base64 -d

Direct API call

#### Print our ARM access token

    az account get-access-token

#### Set access token as a variable

    $token="ACCESS_TOKEN"

#### Get User Data

    Invoke-RestMethod -Method GET -Uri "https://management.azure.com/subscriptions/SUBSCRIPTION_ID/resourceGroups/RESOURCE_GROUP_NAME/providers/Microsoft.Compute/virtualMachines/VM_NAME?api-version=2021-07-01&`$expand=userData" -Headers @{Authorization = "Bearer $token"}

#### Decode content

    echo BASE64_USER_DATA | base64 -d

## Azure Network

### 1) Get the public IP address of a VM

    az network public-ip show --resource-group RESOURCE_GROUP_NAME --name VM_NAME --query "ipAddress" --output tsv

## Azure RBAC

### 1) List permissions of our account on resources

Azure PowerShell

    Get-AzRoleAssignment

### 2) Check Azure RBAC roles assigned to an identity

    az role assignment list --assignee CLIENT_ID --all -o json | grep roleDefinitionName -B 1

### 3) Check details for a role

Azure CLI

    az role definition show --id "/subscriptions/SUBSCRIPTION_ID/providers/Microsoft.Authorization/roleDefinitions/ROLE_DEFINITION_ID" --query "permissions"

Azure PowerShell

    Get-AzRoleDefinition -Id ROLE_DEFINITION_ID | select -ExpandProperty Actions

Azure PowerShell (Use role name instead of RoleID)

    Get-AzRoleDefinition -Name "ROLE_NAME"

## Entra ID

### 1) Query an Enterprise Application notes field (example) by querying the service principal 

    az ad sp show --id CLIENT_ID --query "notes"

### 2) Retrieve the principal object ID

    az ad sp show --id CLIENT_ID --query id -o tsv

## Azure Resource Manager (ARM)

### 1) Deploy resources by reading a template file (parameters can vary according to use case)

    az deployment group create --resource-group RESOURCE_GROUP_NAME --template-file template.json --parameters storageAccountName=STORAGE_ACCOUNT_NAME location=REGION

Template.json example

    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
        "storageAccountName": {
          "type": "string"
        },
        "location": {
          "type": "string"
        }
      },
      "resources": [
        {
          "type": "Microsoft.Storage/storageAccounts",
          "apiVersion": "2022-09-01",
          "name": "[parameters('storageAccountName')]",
          "location": "[parameters('location')]",
          "kind": "StorageV2",
          "sku": {
            "name": "Standard_LRS"
          }
        }
      ]
    }

## Microsoft Graph API (Microsoft 365)

### 1) Situational Awareness

    Get-MgUserOwnedObject -UserId USERNAME@megacorp.com | Select * -ExpandProperty additionalProperties

### 2) Retrieve all applications, extract relevant details, then store the collected data in an XML file for easy parsing and analysis

    # Set up API URI and headers 
    $URI = "https://graph.microsoft.com/v1.0/applications"
    $GraphAccessToken = $graphtoken
    $RequestParams = @{
        Method = 'GET'
        Uri = $URI
        Headers = @{
            'Authorization' = "Bearer $GraphAccessToken"
        }
    }
    
    # Send the request and store the applications details
    $Applications = (Invoke-RestMethod @RequestParams).value
    
    # Create a custom PowerShell object to store applications data
    $ApplicationsDetails = [PSCustomObject]@{
        Applications = @()
    }
    foreach ($Application in $Applications) {
        $applicationObject = [PSCustomObject]@{
            DisplayName = $Application.displayName
            AppId = $Application.appId
            CreatedDateTime = $Application.createdDateTime
            ID = $Application.id
            KeyCredentials = $Application.keyCredentials
            PasswordCredentials = $Application.passwordCredentials
        }
        $ApplicationsDetails.Applications += $applicationObject
    }
    
    # Save the list to a file
    $ApplicationsDetails.Applications | Export-Clixml -Path "Applications.xml"

Search for a pattern in the exported data (example)

    Select-String -Path "./Applications.xml" -Pattern "8A8D9DC753168B8067822151991002FCBF055C71" | ForEach-Object { $start = [Math]::Max(0, $_.LineNumber - 11); Get-Content "./Applications.xml" | Select-Object -Skip $start -First 11 }

Tool: 

1) GraphRunner https://github.com/dafthack/GraphRunner

2) Graph PowerShell Module

Initiate module (GraphRunner)

    Import-Module .\GraphRunner.ps1

Install and initiate the module (Graph PowerShell)

    Install-Module Microsoft.Graph
    Import-Module Microsoft.Graph

### 3) Get a Microsoft Graph Session

GraphRunner

    Get-GraphTokens

Graph PowerShell Module (connect)

    Connect-MgGraph

Print access token

    $tokens.access_token

### 4) Check user's inbox

    Get-Inbox -Tokens $tokens -userid USER.NAME@megacorp.com

### 5) Check SharePoint URLs

    Get-SharePointSiteURLs -Tokens $tokens

### 6) Search and download files that contain a specific term

    Invoke-SearchSharePointAndOneDrive -Tokens $tokens -SearchTerm "password"

### 7) Query information about a Service Principal

    curl -s \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      "https://graph.microsoft.com/v1.0/servicePrincipals/PRINCIPAL_OBJECT_ID" \
    | jq

### 8) Check if the user belongs to a security group or if a directory role has been assigned to them

    Get-MgUserMemberOf -UserId USERNAME@megacorp.com | select * -ExpandProperty additionalProperties | Select-Object {$_.AdditionalProperties["displayName"]}

### 9) Check for any administrative units

    Get-MgDirectoryAdministrativeUnit | fl

### 10) Check if any EntraID users have been assigned a role scoped to an administrative unit

    Get-MgDirectoryAdministrativeUnitScopedRoleMember -AdministrativeUnitId ADMINISTRATIVE_UNIT_ID | Select-Object roleMemberInfo,roleId -ExpandProperty roleMemberInfo

### 11) See what role a user has been assigned

    Get-MgDirectoryAdministrativeUnitScopedRoleMember -AdministrativeUnitId ADMINISTRATIVE_UNIT_ID | fl

### 12) See which role the role ID corresponds to

    $roleId = "ROLE_ID"
    $directoryRoles = Get-MgDirectoryRole | Where-Object { $_.Id -eq $roleId }
    $directoryRoles | Format-List *

### 13) Check more properties of an Administrative Unit

    Get-MgDirectoryAdministrativeUnitMember -AdministrativeUnitId ADMINISTRATIVE_UNIT_ID | Select * -ExpandProperty additionalProperties

## Azure Logic Apps

### 1) Enumerate a specific Azure Logic App

    az logicapp show --resource-group RESOURCE_GROUP_NAME --name LOGIC_APP_NAME

### 2) Access the workflow of a logic app

    az logic workflow list

## Azure VM Scale Set (VMSS)

### 1) Get information about a specific VMSS

    az vmss show --name VMSS_NAME --resource-group RESOURCE_GROUP_NAME

## Azure Container Registry (ACR)

Tool: Docker

Add a user to the Docker group

    sudo usermod -aG docker $USER
    newgrp docker

### 1) Connect to a container registry

Azure PowerShell

    Connect-AzContainerRegistry -Name CONTAINER_REGISTRY_NAME

Azure CLI

    az acr login --name CONTAINER_REGISTRY_NAME

### 2) List registries

    az acr list

### 2) Enumerate available repositories in the registry

Azure CLI

    az acr repository list --name CONTAINER_REGISTRY_NAME

Azure PowerShell

    Get-AzContainerRegistryRepository -RegistryName CONTAINER_REGISTRY_NAME

### 3) Enumerate the repository inside a registry for images

Azure CLI

    az acr repository show-tags --name CONTAINER_REGISTRY_NAME --repository REPOSITORY_NAME 

Azure PowerShell

    Get-AzContainerRegistryRepository -RegistryName CONTAINER_REGISTRY_NAME -Name REPOSITORY_NAME

### 4) Pull an image

    docker pull CONTAINER_REGISTRY_NAME.azurecr.io/REPOSITORY_NAME:latest

### 5) Run the image and explore it

    docker run --rm CONTAINER_REGISTRY_NAME.azurecr.io/REPOSITORY_NAME:latest

Execute remote commands

    docker exec -it CONTAINER_ID /bin/sh

### 6) Check image history

    docker history CONTAINER_REGOSTRY_NAME.azurecr.io/REPOSITORY_NAME:latest --no-trunc --format '{{json .}}' | ConvertFrom-Json | Format-Table -Property CreatedAt, CreatedBy, Size, Comment

