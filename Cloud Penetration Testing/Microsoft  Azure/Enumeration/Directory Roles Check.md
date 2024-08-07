$userEmail = "USER.NAME@DOMAIN.CORP"
$user = Get-MgUser -Filter "userPrincipalName eq '$userEmail'"

$directoryRoles = Get-MgDirectoryRole

$userRoleNames = @()

foreach ($role in $directoryRoles) {
    $members = Get-MgDirectoryRoleMember -DirectoryRoleId $role.Id
    if ($members.Id -contains $user.Id) {
        $userRoleNames += $role.DisplayName
    }
}

$userRoleName
