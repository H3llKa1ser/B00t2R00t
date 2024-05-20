Import-Module MSOline -EA 0

Connect-MsolService -Credential (Get-Credential)

$admins=@()

$roles = Get-MsolRole 

foreach ($role in $roles) {
    $roleUsers = Get-MsolRoleMember -RoleObjectId $role.ObjectId

    foreach ($roleUser in $roleUsers) {
        $roleOutput = New-Object -TypeName PSObject
        $roleOutput | Add-Member -MemberType NoteProperty -Name RoleMemberType -Value $roleUser.RoleMemberType
        $roleOutput | Add-Member -MemberType NoteProperty -Name EmailAddress -Value $roleUser.EmailAddress
        $roleOutput | Add-Member -MemberType NoteProperty -Name DisplayName -Value $roleUser.DisplayName
        $roleOutput | Add-Member -MemberType NoteProperty -Name isLicensed -Value $roleUser.isLicensed
        $roleOutput | Add-Member -MemberType NoteProperty -Name RoleName -Value $role.Name

        $admins += $roleOutput
    }
} 

$admins | Export-Csv -NoTypeInformation ~\Downloads\Crowley365RolesUsers.csv
