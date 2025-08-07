# Managed Identity 

## Use this if you have acquired a token from the metadata URL.

#### 1) Login with the VM's managed identity

    az login --identity 

#### 2)  Make a request for the LinuxVM resource information and cast it to the appid variable

    appid=$(az resource list --query "[?name=='LinuxVM'].identity.principalId" --output tsv) 

#### 3) Using the appid variable, we will list the role assignments for the subscription, specifically querying for the principal name, role name, type, and scope

    az role assignment list --assignee $appid --include-groups --include-inherited --query '[].{username:principalName, role:roleDefinitionName, usertype:principalType, scope:scope}' 
