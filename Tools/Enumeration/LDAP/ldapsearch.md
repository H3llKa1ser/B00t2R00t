## LDAP ENUMERATION WITH LDAPSEARCH

#### 1) ldapsearch -x -p 389 -h DC_IP -b "dc=DOMAIN,dc=LOCAL" -s sub "*" | grep lock (Checks for password lockout policy on accounts to avoid locking them out during a password spray/brute force attack)
