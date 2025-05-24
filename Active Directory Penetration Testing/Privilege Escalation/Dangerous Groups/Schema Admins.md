# Schema Admins

These group members can change the "schema" of the AD. It means they can change the ACLs on the objects that will be created IN THE FUTURE. If we modify the ACLs on the group object, only the future group will be affected, not the ones that are already present.

## 1) Change ACLs on the groups

Give full rights to a user on the groups

    $creds = New-Object System.Management.Automation.PSCredential ("domain.local\user1", (ConvertTo-SecureString "Password" -AsPlainText -Force)); Set-ADObject -Identity "CN=group,CN=Schema,CN=Configuration,DC=domain,DC=local" -Replace @{defaultSecurityDescriptor = 'D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;S-1-5-21-854239470-2015502385-3018109401-52104)';} -Verbose -server dc.domain.local -Credential $creds

When a new group is created we can add any user to it with the user who has full rights

    $User = Get-ADUser -Identity "CN=user1,CN=Users,DC=domain,DC=local"; $Group = Get-ADGroup -Identity "CN=new_admingroup,CN=Users,DC=domain,DC=local"; $creds = New-Object System.Management.Automation.PSCredential ("domain.local\user1", (ConvertTo-SecureString "Password" -AsPlainText -Force)); Add-ADGroupMember -Identity $Group -Members $User -Server dc.domain.local -Credential $creds

