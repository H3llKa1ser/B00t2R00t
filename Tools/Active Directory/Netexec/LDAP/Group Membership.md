# Group Membership

### Enumerate a specific user

    nxc ldap $ip -u $user -p $password -M groupmembership -o USER="USER_NAME"

### Enumerate members of Domain Users

    nxc ldap $ip -u $user -p $password -M group-mem -o GROUP="Domain users"

### Enumerate Domain Admins

    nxc ldap $ip -u $user -p $password -M group-mem -o GROUP="Domain admins"

### List members of a specific group

    nxc ldap $ip -u $user -p $password --groups "GROUP_NAME"
