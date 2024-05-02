# Microburst Azure Security Assessment Tool

## Github repo: https://github.com/NetSPI/MicroBurst

 - Import-Module MicroBurst.psm1

### Look for open storage blobs

 - Invoke-EnumerateAzureBlobs -Base $BaseName

### Export SSL/TLS certs

 - Get-AzPasswords -ExportCerts Y

### Azure Container Registry dump

 - Get-AzPasswords

 - Get-AzACR

### Enumerate Potential Azure Subdomains Anonymously

 - Invoke-EnumerateAzureSubDomains -Base BASE_NAME
