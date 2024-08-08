# Pfx certificates 

### Command:

 - Get-PfxCertificate -FilePath /path/to/file.pfx | fl (Check more information on a .pfx file to see who is the issuer)

 - Get-ChildItem -Path C:\Users\USER\Downloads\file.pfx | Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -Exportable (Add certificate to our local store in windows)
