# Azure Blob Storage Service (Equivalent to the S3 bucket of AWS)

### URL Example: https://mbtwebsite.blob.core.windows.net/$web/index.html

### URL Components:

 - https = Protocol used

 - mbtwebsite = The name of the Azure Storage Account associated with the website. An Azure Storage Account is a foundational service in Microsoft Azure that provides scalable and durable storage for various types of data, including files, blobs, tables, and queues.

 - blob.core.windows.net = The is the Azure Blob Storage Service

 - $web = The name of the container hosting the website, and it is situated within the storage account

 - index.html = The web page being requested

### URL to explore the container: https://mbtwebsite.blob.core.windows.net/$web?restype=container&comp=list

### URL to return all directories in the container using the / delimiter: https://mbtwebsite.blob.core.windows.net/$web?restype=container&comp=list&delimiter=%2F

### URL to list previous blob versions to check for sensitive files that were temporary there: https://mbtwebsite.blob.core.windows.net/$web?restype=container&comp=list&include=versions

 - curl -H "x-ms-version: 2019-12-12" 'https://mbtwebsite.blob.core.windows.net/$web?restype=container&comp=list&include=versions' | xmllint --format - | less (Check for previous versions using CLI instead)
