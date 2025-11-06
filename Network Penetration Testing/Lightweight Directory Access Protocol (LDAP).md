# Lightweight Directory Access Protocol (LDAP)

Port: 389, 636, 3268, 3269

### 1) Nmap scan

    nmap -n -sV --script "ldap* and not brute" IP

### 2) Ldapsearch

Basic LDAP query

    ldapsearch -x -H ldap://IP

Basic LDAP search for a base-level

    ldapsearch -h IP -x -s base

Get Naming Contexts

    ldapsearch -x -H ldap://IP -s base namingcontexts

Search in a specific base domain name

    ldapsearch -x -H ldap://IP -b "DC=<domain>,DC=<tld>"

Enumerate users via LDAP

    ldapsearch -v -x -b "DC=<domain>,DC=<tld>" -H "ldap://IP" "(objectclass=*)"

Retrieve users Account Name

    ldapsearch -v -x -b "DC=<domain>,DC=<tld>" -H "ldap://IP" "(objectclass*)" | grep sAMAccountName:

Search with filters

    ldapsearch -x -H ldap://IP -b "DC=<domain>,DC=<tld>" "(objectclass=user)"
    ldapsearch -x -H ldap://IP -b "DC=<domain>,DC=<tld>" "(objectclass=group)"

Authenticated enumeration

    ldapsearch -h <target_ip> -x -D 'domain.tld\USER' -w 'PASSWORD' -b "DC=<domain>,DC=<tld>"

Searching terms

    ldapsearch -h <target_ip> -x -D 'domain.tld\USER' -w 'PASSWORD' -b "DC=<domain>,DC=<tld>" "<term>"

Specifies the value term to return

    ldapsearch -h <target_ip> -x -D 'domain.tld\USER' -w 'PASSWORD' -b "DC=<domain>,DC=<tld>" "<term>" ADDITIONAL_TERM

### 3) Check Pre-Authentication for Usaers

    kerbrute userenum -d domain.tld --dc DC_IP USERLIST

### 4) LDAP Queries

#### Search Terms to Find Cleartext Passwords

Search for ms-MCS-AdmPwd (local administrator passwords)

    (ms-MCS-AdmPwd=*)

Search for attributes containing 'password' in description

    (description=*password*)

Search for LAPS expiration time (to identify potential password management)

    (ms-MCS-AdmPwdExpirationTime=*)

Search for common weak passwords in attributes like description

    (description=*(123456*|password*|qwerty*|letmein*))

#### General LDAP Filters

Search for All Users

    (objectClass=user)

Search for All Computers

    (objectClass=computer)

Search for All Groups

    (objectClass=group)

Search for Disabled Accounts

    (userAccountControl:1.2.840.113556.1.4.803:=2)

Search for Expired Accounts

    (& (objectClass=user)(!userAccountControl:1.2.840.113556.1.4.803:=2)(!(pwdLastSet=0)))

Search for Specific Group Membership

    (&(objectClass=user)(memberOf=CN=GroupName,OU=Groups,DC=domain,DC=com))

#### Search for Users with Specific Attributes

For users with a specific email domain

    (mail=*@example.com)

For users with a specific title

    (title=Manager)

#### Specific Attributes

Search for Password Last Set

    (pwdLastSet=*)

Search for Accounts with Expired Passwords

    (& (objectClass=user)(pwdLastSet<=0))

Search for Accounts in a Specific Organizational Unit (OU)

    (distinguishedName=*,OU=Sales,DC=domain,DC=com)

#### Security-Related searches

Search for Accounts with Kerberos Pre-Authentication Disabled

    (userAccountControl:1.2.840.113556.1.4.803:=4194304)

Search for Service Principal Names (SPNs)

    (servicePrincipalName=*)

Search for Delegated Users

    (msDS-AllowedToDelegateTo=*)

Search for Accounts with Privileges

    (memberOf=CN=Domain Admins,CN=Users,DC=domain,DC=com)

#### Other useful searches

Search for All Organizational Units

    (objectClass=organizationalUnit)

Search for Active Directory Certificate Services

    (objectClass=cACertificate)

Search for All Attributes of a Specific User

    (sAMAccountName=username)

Search for Accounts with Specific Notes or Descriptions

    (description=*keyword*)

Search for all objects in the directory

    (objectClass=*)

Search for service accounts

    (objectCategory=serviceAccount)

Search for accounts with specific group memberships (replace 'GroupName')

    (memberOf=CN=GroupName,OU=Groups,DC=domain,DC=com)

Search for computer accounts

    (objectClass=computer)

Search for users in a specific organizational unit (replace 'OU=Users')

    (ou=OU=Users,DC=domain,DC=com)

Search for all accounts with specific attributes

    (pwdLastSet=0)
