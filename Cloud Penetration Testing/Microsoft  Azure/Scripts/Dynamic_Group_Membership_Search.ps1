$dynamicGroups = Get-MgGroup -Filter "groupTypes/any(c:c eq 'DynamicMembership')"

foreach ($group in $dynamicGroups) {
    $groupName = $group.DisplayName
    $membershipQuery = $group.MembershipRule
    Write-Output "Group Name: $groupName, Membership Query: $membershipQuery"
}
