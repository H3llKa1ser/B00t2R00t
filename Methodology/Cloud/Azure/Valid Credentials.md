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

### 2) List containers

    az storage container list --acount-name STORAGE_ACCOUNT_NAME --auth-mode login -o table

### 3) List blobs in the container

    az storage blob list --account-name STORAGE_ACCOUNT_NAME --container-name CONTAINER_NAME --auth-mode login -o table

### 4) Download container contents

    az storage blob download --account-name STORAGE_ACCOUNT_NAME --container-name CONTAINER_NAME --name BLOB_NAME --file BLOB_NAME --auth-mode login

## Azure Key Vault

### 1) List secrets

    az keyvault secret list --vault-name VAULT_NAME -o table

### 2) List keys

    az keyvault key list --vault-name VAULT_NAME -o table

### 3) Perform decryption

Encode our downloaded content to base64

    base64 < BLOB_NAME | tr -d '\n' > BASE64_ENCODED_BLOB

Decrypt by calling the vault directly using the stored key. (Azure handles the decryption and returns plaintext)

    az keyvault key decrypt --vault-name VAULT_NAME --name KEY_NAME --algorithm RSA-OAEP --value BASE64_ENCODED_BLOB --query result -o tsv | base64 -d > BLOB_PLAINTEXT

## Resources

### 1) List Resources

Azure CLI

    az resource list

Azure PowerShell

    Get-AzResource

### 2) Get URL of a specific resource

    (Get-AzWebApp -ResourceGroupName "RESOURCE_GROUP_NAME" -Name "APP_NAME").DefaultHostName

