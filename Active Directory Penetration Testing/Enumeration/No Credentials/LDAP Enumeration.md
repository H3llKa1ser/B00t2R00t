# LDAP Enumeration

## Tools: nmap , ldapsearch, netexec

### 1) Nmap

    nmap -n -sV --script "ldap* and not brute" -p 389 DC_IP

### 2) ldapsearch

    ldapsearch -v -x -b "DC=domain,DC=local" -H "ldap://DC_IP" "(objectclass=*)"

### 3) Netexec

Enumerate users

    nxc ldap -u USER -p PASS --users

Get user passwords

    nxc ldap IP -u USER -p PASS -M get-userPassword

Get user descriptions (check out sensitive information like passwords)

    nxc ldap <hostname> -u <user> -p <pass> -M get-desc-users


### If we find a valid user or sensitive information, we can try techniques by using that info
