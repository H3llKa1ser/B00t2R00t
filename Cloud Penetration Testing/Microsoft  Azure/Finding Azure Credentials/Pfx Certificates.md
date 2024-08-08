# Pfx certificates 

### Command:

 - Get-PfxCertificate -FilePath /path/to/file.pfx | fl (Check more information on a .pfx file to see who is the issuer)

 - Get-ChildItem -Path C:\Users\USER\Downloads\file.pfx | Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -Exportable (Add certificate to our local store on windows)

### Authenticate to the tenant via certificate

$tenantId = "2590ccef-687d-493b-ae8d-441cbab63a72"
$clientId = "20acc5dd-ffd4-41ac-a1a5-d381329da49a"
$certThumbprint = "8641763A94ED35C77DBA10E5A302DDDE29EE6769"

$store = New-Object System.Security.Cryptography.X509Certificates.X509Store("My", "CurrentUser")
$store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadOnly)
$cert = $store.Certificates.Find([System.Security.Cryptography.X509Certificates.X509FindType]::FindByThumbprint, $certThumbprint, $false)[0]
$store.Close()

 - Connect-AzAccount -CertificateThumbprint $certThumbprint -ApplicationId $clientId -TenantId $tenantId -ServicePrincipal
