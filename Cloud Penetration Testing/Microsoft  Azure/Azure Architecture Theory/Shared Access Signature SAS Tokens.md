# Shared Access Signatures Tokens (SAS)

### SAS tokens provide (hopefully secure) access to resources in an Azure storage account. Hopefully, because the security still depends on the access grants, and also how the token has been stored...

### Azure storage account resources can be accessed using a SAS URI . A SAS Uniform Resource Identifier (URI) is a unique sequence of characters that identifies a resource. Azure SAS URIs are comprised of a Storage Resource URI and a SAS token.

# SAS URI Structure

## Storage URI

 - https://STORAGE_ACCOUNT_NAME.blob.core.windows.net/container/file.pdf

## SAS Token

 - ?sv=2022-11-02&ss=bfqt&srt=sco&sp=rl&se=2099-05-06T06:03:29Z&st=2024-05-05T22:03:29Z&spr=https&sig=Dws3bgGUWCUknRdVmRoFXItmnItJDLHy76Axgu1qNtE="

# SAS Token Structure

 - 1) sv (Service Version): Specifies the version of the Storage service API to use. This is set to "2022-11-02".

 - 2) ss (Services): Indicates which services the SAS token applies to. Here, it includes:

 - 3) b for Blob storage,

 - 4) f for File storage,

 - 5) q for Queue storage,

 - 6) t for Table storage.

 - 7) srt (Resource Types): Specifies the types of resources that are accessible with the SAS token. This includes:

 - 8) s for Service (e.g., Get service properties),

 - 9) c for Container (e.g., List blobs in container),

 - 10) o for Object (e.g., Read blob content).

 - 11) sp (Permissions): Details the permitted actions. In this case:

 - 12) r for Read access,

 - 13) l for List capabilities.

 - 14) se (End Time): Defines the expiration time of the SAS token. Here, it is set to "2099-05-06T06:03:29Z", indicating the token is valid until May 6, 2099.

 - 15) st (Start Time): Specifies the start time from when the token becomes valid. For this token, it's "2024-05-05T22:03:29Z".

 - 16) spr (Protocol): Restricts the protocols through which the resources can be accessed. It’s set to HTTPS, ensuring all communications are secure.

 - 17) sig (Signature): The cryptographic signature, which is an encoded string generated from the account key and the string-to-sign. It is used to authenticate the SAS token request

## SAS Tokens can be used to authenticate with Azure CLI
