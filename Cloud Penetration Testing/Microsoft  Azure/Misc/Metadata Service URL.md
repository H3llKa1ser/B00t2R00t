# Metadata Service URL

 - http://169.254.169.254/metadata

### Get access tokens from the metadata service

 - GET 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/' HTTP/1.1 Metadata: true

### Check if we are inside an Azure VM 

    Invoke-RestMethod -Headers @{"Metadata"="true"} -Uri "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | fl *
