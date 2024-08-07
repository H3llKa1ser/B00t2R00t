$userId = "USER.NAME@DOMAIN.CORP"
$groupIds = (Get-MgUserMemberOf -UserId $userId).Id

$groupNames = @()

foreach ($groupId in $groupIds) {
    $group = Get-MgGroup -GroupId $groupId
    $groupNames += $group.DisplayName
}

$groupNames
