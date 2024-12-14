## LDAP ENUMERATION WITH LDAPSEARCH

#### 1) 

    ldapsearch -x -p 389 -h DC_IP -b "dc=DOMAIN,dc=LOCAL" -s sub "*" | grep lock 
    
(Checks for password lockout policy on accounts to avoid locking them out during a password spray/brute force attack)

#### 2) 

    └─$ ldapsearch -x -H ldap://TARGET_IP -D "USERNAME@DOMAIN.COM" -w "PASSWORD" -b "DC=DOMAIN,DC=COM" "(objectClass=user)" sAMAccountName memberOf       

(Enumerates all users and computers via LDAP)

#### 3)

        ldapsearch -x -H ldap://TARGET_IP -D "USERNAME@DOMAIN.COM" -w "PASSWORD" -b "DC=DOMAIN,DC=COM" "(objectClass=user)" sAMAccountName | grep "sAMAccountName:" | cut -d " " -f 2 > usernames.txt

(Dump all enumerated users into a usernames list file to use for other attacks with other tools like impacket)
