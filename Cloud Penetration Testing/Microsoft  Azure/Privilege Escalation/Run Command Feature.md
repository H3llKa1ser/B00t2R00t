# Exploiting Run Command Feature

## Requirements: Contributor account/role access

### The Run Command feature of Azure VMs is a platform feature used to run scripts on VMs remotely using the VM agent. It can be used to run PowerShell scripts on Windows VMs and shell scripts on Linux VMs. It is generally used by administrators or developers to quickly diagnose and remediate VM access and network issues and get the VM back to a good state.

### Here is some information to keep in mind when exploiting this feature:

- Scripts run as the System account on Windows VMs and as an elevated user (typically root) on Linux VMs.

- We can only run one script at a time through the feature.

- Interactive scripts that prompt for user information are not supported.

- Outbound connectivity from the VM to Azure public IP addresses on port 443 is required to return the results of the script.

