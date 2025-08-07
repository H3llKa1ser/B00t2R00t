# Global Administrator Privesc Scenarios

## Scenario 1 steps:

#### 1) Login as the Global Admin

    az login 

#### 2) Get tenant-level access, then sign in again

    az login --allow-no-subscriptions 

#### 3) Exploit the Global Admin role to modify privileges to Azure resources

    az rest --method post --url "/providers/Microsoft.Authorization/elevateAccess?api-version=2016-07-01" 

#### 4) Logout, then relogin

    az logout

    az login (Reauthenticate back)

    userPrincipalName=$(az ad signed-in-user show --query userPrincipalName -o tsv)

#### 5) Assign the subscription Owner role to the Global Administrator account

    az role assignment create --role "Owner" --assignee $userPrincipalName 

### The commands will be successful, proving that you have used your elevated Global Administrator role to modify permissions for Azure resources!

