# Valid Credentials

### 1) Authenticate

User

    az login -u USER - p PASSWORD --tenant TENANT_ID

Service Principal

    az login --service-principal -u CLIENT_ID -p SECRET --tenant TENANT_ID

### 2) List resources our account has access to (either read or write)

    az resource list

## Storage Accounts

### 1) List storage account keys

    az storage account keys list -g RESOURCE_GROUP -n NAME

Entra-based (RBAC Auth)

    az account set --subscription SUBSCRIPTION_ID
    KEY=$(az storage account keys list -g RESOURCE_GROUP -n NAME --query '[0].value' -o tsv)

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

    az keyvault key decrypt --vault-name VAULT_NAME --name KEY_NAME --algorithm RSA-OAEP --value BASE64_ENCODED_BLOB --query result -o tsv | base64 -d > BLOB_PLAINTEXT
