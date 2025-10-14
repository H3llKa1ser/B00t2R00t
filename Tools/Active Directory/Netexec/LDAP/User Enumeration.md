# User Enumeration

### To enumerate all users via LDAP:

    nxc ldap $ip -u $user -p $password --users

### To enumerate just the active users via LDAP:

    nxc ldap $ip -u $user -p $password --active-users

### To enumerate accounts that exist within Active Directory without the Kerberos protocol. (Do ASREPRoasting of valid users are found)

    nxc ldap $ip -u "user.txt" -p '' -k
