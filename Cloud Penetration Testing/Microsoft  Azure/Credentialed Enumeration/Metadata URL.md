# IMDS REST API endpoint 

### Obtain information about the instance platform as well as request access tokens if the instance is a managed identity.

 - curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?apiversion=2020-09-01" | jq (Review the instance metadata to obtain more information about how the VM is configured in Azure)

 - curl -H Metadata:true -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' | jq (Check whether the VM has an associated managed identity using the following command. If one is used, an access_token will be returned and this could present an opportunity to escalate privileges)

 - az login --identity (Log in with the VM's managed identity) 

 - appid=$(az resource list --query "[?name=='LinuxVM'].identity.principalId" --output tsv) (make a request for the LinuxVM resource information and cast it to the appid variable.)

 - az role assignment list --assignee $appid --include-groups --include-inherited --query '[].{username:principalName, role:roleDefinitionName, usertype:principalType, scope:scope}' (Using the appid variable, we will list the role assignments for the subscription, specifically querying for the principal name, role name, type, and scope)




   
