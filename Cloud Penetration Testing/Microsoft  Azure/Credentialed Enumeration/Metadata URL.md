# IMDS REST API endpoint 

### Obtain information about the instance platform as well as request access tokens if the instance is a managed identity.

#### 1) Review the instance metadata to obtain more information about how the VM is configured in Azure

    curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?apiversion=2020-09-01" | jq 

#### 2) Check whether the VM has an associated managed identity using the following command. If one is used, an access_token will be returned and this could present an opportunity to escalate privileges

    curl -H Metadata:true -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' | jq 





   
