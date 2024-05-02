# Managed Identity 

## Use this if you have acquired a token from the metadata URL.

 - az login --identity (Log in with the VM's managed identity) 

 - appid=$(az resource list --query "[?name=='LinuxVM'].identity.principalId" --output tsv) (make a request for the LinuxVM resource information and cast it to the appid variable.)

 - az role assignment list --assignee $appid --include-groups --include-inherited --query '[].{username:principalName, role:roleDefinitionName, usertype:principalType, scope:scope}' (Using the appid variable, we will list the role assignments for the subscription, specifically querying for the principal name, role name, type, and scope)
