# Azure CLI Authenticated Enumeration

## Any operation running with azure-cli, is assumed that we have already compromised a user and have access inside the Azure environment.

### Commands:

#### 1) Authenticate with our compromised account 

    az login -u USER@DOMAIN.CORP -p 'PASSWORD'

#### 2) Logout from our current user

    az account clear 

#### 3) Shows all resources that our current user has access to

    az resource list 

#### 4) Return general information about a VM

    az vm show --resource-group GROUP --name VM_NAME 

#### 5) Gives the access token of the account

    az account get-access-token 

#### 6) Enumerate EntraID users within the tenant

    az ad user list 

#### 7) Do a filtered enumeration depending on use case

    az ad user list --filter "startsWith('wvusr-', displayName)" 

#### 8) Enumerate EntraID groups

    az ad group list 

#### 9) Enumerate members of a specific group

    az ad group member list --group "GROUP_NAME"

#### 10) Check what role is assigned to a specific group

    az role assignment list --assignee GROUP_ID --all

#### 11) List any accessible key vaults

    az keyvault list 

#### 12) Check if secrets are stored inside this vault

    az keyvault secret list --vault-name VAULT_NAME 

#### 13) Reveal the values inside the secret within the specific vault

    az keyvault secret show --vault-name VAULT_NAME --name SECRET_NAME 
