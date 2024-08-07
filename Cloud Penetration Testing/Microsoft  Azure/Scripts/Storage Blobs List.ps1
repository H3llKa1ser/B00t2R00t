$context = New-AzStorageContext -StorageAccountName storageqaenv
$containername = (Get-AzStorageContainer -Context $context -Name general-purpose).name
Get-AzStorageBlob -Container $containername -Context $context
