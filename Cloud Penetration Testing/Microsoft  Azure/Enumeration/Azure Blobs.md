# Azure Blobs Enumeration

Tool: Microburst

### 1) Brute-force storage account names, containers and files. Uses permutations to discover storage accounts.

    Import-Module .\MicroBurst.psm1

    Invoke-EnumerateAzureBlobs -Base company.com -OutputFile azureblobs.txt

## Data in public blobs

#### NOTE: Containers =/= Blobs

Containers organize a set of blobs. Similar to a directory in a file system.

Predictable URLs at core.windows.net

    storage-account-name.blob.core.windows.net
    storage-account-name.file.core.windows.net
    storage-account-name.dfs.core.windows.net
    storage-account-name.table.core.windows.net
    storage-account-name.queue.core.windows.net
    storage-account-name.database.windows.net

#### Access Policy in Blob/Containers

Blob: Anyone can anonymously read blobs, but can't list the blobs in the container.

Container: Allows for listing containers and blobs.

### Discovery with dnscan.py

    python dnscan.py -d blob.core.windows.net -w subdomains-100.txt

You can use other predictable URLs at core.windows.net

### Cloud_Enum

https://github.com/initstring/cloud_enum

Cloud_enum tool permits to enumerate Azure Storage accounts, blob containers, hosted DBs, VM and WebApps.

    python3 cloud_enum.py --disable-aws --disable-gcp -k companyName

### CloudBrute

https://github.com/0xsha/CloudBrute

Brute forcing tool to find Microsoft Storage or Apps

    ./CloudBrute -d company.com -k company -t 80 -T 10 -c microsoft -m storage -w ./data/storage_small.txt
