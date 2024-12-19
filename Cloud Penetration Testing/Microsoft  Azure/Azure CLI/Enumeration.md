# Azure CLI Authenticated Enumeration

## Any operation running with azure-cli, is assumed that we have already compromised a user and have access inside the Azure environment.

### Commands:

 - az login -u USER@DOMAIN.CORP -p 'PASSWORD' (Authenticate with our compromised account)

 - az account clear (Logout from our current user)

 - az resource list (Shows all resources that our current user has access to)

 - az vm show --resource-group GROUP --name VM_NAME (Return general information about a VM)

 - az account get-access-token (Gives the access token of the account.)

 - az ad user list (Enumerate EntraID users within the tenant)

 - az ad user list --filter "startsWith('wvusr-', displayName)" (Do a filtered enumeration depending on use case)

 - az ad group list (Enumerate EntraID groups)

 - az ad group member list --group "GROUP_NAME" (Enumerate members of a specific group)

 - az role assignment list --assignee GROUP_ID --all (Check what role is assigned to a specific group.)

 - az keyvault list (List any accessible key vaults)

 - az keyvault secret list --vault-name VAULT_NAME (Check if secrets are stored inside this vault)

 - az keyvault secret show --vault-name VAULT_NAME --name SECRET_NAME (Reveal the values inside the secret within the specific vault)
