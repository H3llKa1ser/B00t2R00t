# Add credentials to enterprise applications

To add credentials (application passwords) to enterprise applications in Azure, follow these steps and commands:

### 1) Check if Secrets can be added

    . .\Add-AzADAppSecret.ps1
    Add-AzADAppSecret -GraphToken $graphtoken -Verbose

### 2) Use the Secret to authenticate as Service Principal

    $password = ConvertTo-SecureString '<SECRET>' -AsPlainText -Force
    $creds = New-Object System.Management.Automation.PSCredential('<ACCOUNT ID>', $password)

    Connect-AzAccount -ServicePrincipal -Credential $creds -Tenant <TENANT ID>

### 3) Check what resources Service Principal can access

    Get-AzResource

    
