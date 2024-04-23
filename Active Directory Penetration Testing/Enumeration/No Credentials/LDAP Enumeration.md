# LDAP Enumeration

## Tools: nmap , ldapsearch

 - nmap -n -sV --script "ldap* and not brute" -p 389 DC_IP

 - ldapsearch -x -h DC_IP -s base

### If we find a value user, we can try techniques by using that name
