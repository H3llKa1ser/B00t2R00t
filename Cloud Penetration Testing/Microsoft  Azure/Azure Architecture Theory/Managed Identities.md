# Azure Managed Identities

### Distributed cloud resources often have the need to interact with other resources in Azure and can be configured with a user or system-managed identity that allows them to authenticate. An API endpoint is accessible on a private (non-internet routable) IP address that allows the application to retrieve a token for the managed identity and interact with Azure. The API endpoint URL is like the example below, with the last two octets of the IP address rotating periodically.

### A identity header in the form of a Universally Unique IDentifier (UUID) is also needed to interact with this API endpoint, providing an additional layer of security. Both this rotating header and URL are made available as environment variables in the application operating system.

## PROTIP: Searching for IDENTITY on the env output may return hits for the header and endpoint that we need to construct our request.
