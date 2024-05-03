# Hunting credentials in Azure Container Registry

### For many Azure services, Microsoft usually keeps a separation between management plane access and data plane access. This means that explicit permissions beyond the typical management roles are needed to access data stored within services. This architecture was not implemented for the ACR service. It is an interesting architecture choice, but Azure users with Reader permissions on any Azure container registries have rights to connect to the container registry and access images. These users do not have any rights to push modified images back to the registry, but they are able to download and run container images locally. This allows us, as attackers, to review the contents of the images and potentially find issues in the application code, access secrets used by the application, and pivot with those secrets into other applications and services. 

### The process to do this is very simple. As an authenticated user, with Reader or higher permissions on the registry, we can generate a Docker login from the Azure CLI.

## Steps

 - az login -u READER_USER@DOMAIN.LOCAL -p PASSWORD (Authenticate to the Azure environment using the reader role)

 - az acr list -o table (List the container registries in the subscription)

### Generate a Docker login for the registry

 - acr=ACR_NAME (Store the container registry in a variable)

 - loginserver=$(az acr login -n $acr --expose-token --query loginServer -o tsv)

 - accesstoken=$(az acr login -n $acr --expose-token --query accessToken -o tsv)

 - docker login $loginserver -u 00000000-0000-0000-0000-000000000000 -p $accesstoken

 - az acr repository list -n $acr (List the images in the container registry)

 - az acr repository show-tags -n $acr --repository REPOSITORY (List the tags for a specific container registry to enumerate image versions)

### Make note of the registry credentials for further usage

 - echo $loginserver

 - echo $accesstoken
   

