# What can I do with a certificate?

### Before checking how to steal the certificates here you have some info about how to find what the certificate is useful for:

#### 1) cmd

    certutil.exe -dump -v cert.pfx

#### 2) powershell

    $CertPath = "C:\path\to\cert.pfx"

    $CertPass = "P@ssw0rd"

    $Cert = New-Object

    System.Security.Cryptography.X509Certificates.X509Certificate2 @($CertPath, $CertPass)

    $Cert.EnhancedKeyUsageList
