# Azure CLI Authenticated Enumeration

## Any operation running with azure-cli, is assumed that we have already compromised a user and have access inside the Azure environment.

### Commands:

 - az login -u USER@DOMAIN.CORP -p 'PASSWORD' (Authenticate with our compromised account)

 - az resource list (Shows all resources that our current user has access to)

 - az vm show --resource-group GROUP --name VM_NAME (Return general information about a VM)

 - az account get-access-token (Gives the access token of the account.)

 - az ad user list (Enumerate EntraID users within the tenant)
