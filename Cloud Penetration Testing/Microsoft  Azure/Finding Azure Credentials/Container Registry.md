# Hunting credentials in Azure Container Registry

### For many Azure services, Microsoft usually keeps a separation between management plane access and data plane access. This means that explicit permissions beyond the typical management roles are needed to access data stored within services. This architecture was not implemented for the ACR service. It is an interesting architecture choice, but Azure users with Reader permissions on any Azure container registries have rights to connect to the container registry and access images. These users do not have any rights to push modified images back to the registry, but they are able to download and run container images locally. This allows us, as attackers, to review the contents of the images and potentially find issues in the application code, access secrets used by the application, and pivot with those secrets into other applications and services. 

### The process to do this is very simple. As an authenticated user, with Reader or higher permissions on the registry, we can generate a Docker login from the Azure CLI.

## Steps

 - az login -u READER_USER@DOMAIN.LOCAL -p PASSWORD (Authenticate to the Azure environment using the reader role)

 - az acr list -o table (List the container registries in the subscription)
