# Enumerate Public IP Addresses

## Azure CLI

 - az network public-ip list --query '[].[name, ipAddress, publicIpAllocationMethod]' -o table

## Az Powershell Module

 - Get-AzPublicIpAddress | Select Name,IpAddress,PublicIpAllocationMethod

### It is important to note that dynamically allocated addresses can change and, if tested later, may no longer be assigned to the organization that you are engaged with. For these situations, it might be worth targeting DNS host names, as they will automatically update when the IP address changes. This will help us avoid scanning the IP addresses of other Azure customers. Additionally, we recommend running any public IP scans immediately after gathering the IPs.

## URL to download the JSON file that contains public Azure IP Ranges and Service Tags:

 - https://www.microsoft.com/en-us/download/details.aspx?id=56519 (Azure public cloud)

 - https://www.microsoft.com/en-us/download/details.aspx?id=57063 (Azure US Government cloud)


