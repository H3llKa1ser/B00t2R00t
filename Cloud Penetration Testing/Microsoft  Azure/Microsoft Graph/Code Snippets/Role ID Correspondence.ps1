$roleId = "ROLE_ID"
$directoryRoles = Get-MgDirectoryRole | Where-Object { $_.Id -eq $roleId }
$directoryRoles | Format-List *
