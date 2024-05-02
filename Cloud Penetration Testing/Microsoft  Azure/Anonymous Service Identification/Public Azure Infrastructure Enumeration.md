# Enumerate Public IP Addresses

## Azure CLI

 - az network public-ip list --query '[].[name, ipAddress, publicIpAllocationMethod]' -o table

## Az Powershell Module

 - Get-AzPublicIpAddress | Select Name,IpAddress,PublicIpAllocationMethod

### It is important to note that dynamically allocated addresses can change and, if tested later, may no longer be assigned to the organization that you are engaged with. For these situations, it might be worth targeting DNS host names, as they will automatically update when the IP address changes. This will help us avoid scanning the IP addresses of other Azure customers. Additionally, we recommend running any public IP scans immediately after gathering the IPs.

## URL to download the JSON file that contains public Azure IP Ranges and Service Tags:

 - https://www.microsoft.com/en-us/download/details.aspx?id=56519 (Azure public cloud)

 - https://www.microsoft.com/en-us/download/details.aspx?id=57063 (Azure US Government cloud)

### Alternate download method: Powershell

 - Invoke-WebRequest JSON_URL -O azure_ip_range.json

 - $jsonData = gc .\azure_ip_range.json | ConvertFrom-Json ($jsonData | select -ExpandProperty values | where name -EQ AzureCloud.uksouth).properties.addressPrefixes (Azure UK South region example)

# Azure platform DNS suffixes

### When an Azure customer creates an instance of a resource, Azure assigns it a subdomain of the associated DNS suffix in the format of:

 - RESOURCE_INSTANCE_NAME.SERVICE_DNS_SUFFIX_NAME

 - azurepentesting.blob.core.windows.net (Example)

 - nslookup DOMAIN.LOCAL (Check the domain if the site is hosted in Azure)

## To anonymously enumerate platform services in Azure, a pentester can use the following methodology:

#### 1) Determine base-word search terms to work with. This will usually be linked with the name of the Azure customer that you are engaged with or known terms that are associated with the organization; for example, packt, azurepentesting, azurept, and so on.

#### 2) Create permutations on the base words to identify potential subdomain names; for example, packt-prod, packt-dev, azurepentesting-stage, azurept-qa, and so on.

### Microsoft Azure resource naming best practices:

 - https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-bestpractices/resource-naming

#### 3) Enumerate subdomains that match these permutations using a tool such as MicroBurst, Gobuster, or DNSscan

## TIP: The advantage that MicroBurst has over other tools such as Gobuster and DNSscan is that it is Azure-specific, which means we don't have to manually figure out each DNS suffix that we want to enumerate!

# Custom domains and IP ownership

### Some Azure services allow customers to use custom domains. Additionally, some hosts may have redirects or transparent proxies in place to obfuscate the fact that the services are hosted in Azure. As part of the penetration testing process, you will want to fully understand where your targets live, as it could make a major difference in your scope. For example, your external penetration test scope may include specific IPs and hostnames for the environment that you are authorized to attack. If these hosts end up being in Azure, that will influence how we go about attacking those specific resources.


