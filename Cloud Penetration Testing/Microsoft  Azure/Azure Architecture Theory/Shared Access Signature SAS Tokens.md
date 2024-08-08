# Shared Access Signatures Tokens (SAS)

### SAS tokens provide (hopefully secure) access to resources in an Azure storage account. Hopefully, because the security still depends on the access grants, and also how the token has been stored...

### Azure storage account resources can be accessed using a SAS URI . A SAS Uniform Resource Identifier (URI) is a unique sequence of characters that identifies a resource. Azure SAS URIs are comprised of a Storage Resource URI and a SAS token.

## Storage URI

 - https://WHATEVER.blob.core.windows.net/container/file.pdf

## SAS Token

 - ?sv=2022-11-02&ss=bfqt&srt=sco&sp=rl&se=2099-05-06T06:03:29Z&st=2024-05-05T22:03:29Z&spr=https&sig=Dws3bgGUWCUknRdVmRoFXItmnItJDLHy76Axgu1qNtE="
