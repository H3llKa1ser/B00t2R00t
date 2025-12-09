# LDAP Enumeration

## Tools: nmap , ldapsearch

    nmap -n -sV --script "ldap* and not brute" -p 389 DC_IP

    ldapsearch -v -x -b "DC=domain,DC=local" -H "ldap://DC_IP" "(objectclass=*)"

### If we find a valid user or sensitive information, we can try techniques by using that info
