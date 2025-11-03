# Active Directory Usernames

### 1) Ldapsearch

    ldapsearch -x -H ldap://IP -b "DC=domain,DC=local" "(objectClass=person)" userPrincipalName | tee ldap-userEnum.txt

Filter to only usernames from ldapsearch output

    cat ldap-userEnum.txt | grep user | awk '{print $2}' | sed '1d' | cut -d@ -f 1 > username.txt
