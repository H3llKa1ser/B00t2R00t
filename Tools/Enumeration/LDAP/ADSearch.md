# ADSearch LDAP Enumeration tool

## Link: https://github.com/tomcarver16/ADSearch

### Usage:

 - ADSearch.exe --hostname HOSTNAME.DOMAIN.LOCAL --username USER --password PASS --domain DOMAIN.LOCAL --users (Enumerate all users)

 - ADSearch.exe --hostname HOSTNAME.DOMAIN.LOCAL --username USER --password PASS --domain DOMAIN.LOCAL --spn (Enumerate SPNs)

 - ADSearch.exe --hostname HOSTNAME.DOMAIN.LOCAL --username USER --password PASS --domain DOMAIN.LOCAL --domain-admins (Enumerate domain admins)

 - ADSearch.exe --hostname HOSTNAME.DOMAIN.LOCAL --username USER --password PASS --domain DOMAIN.LOCAL --computers (Enumerate domain joined computers)

 - ADSearch.exe --hostname HOSTNAME.DOMAIN.LOCAL --username USER --password PASS --domain DOMAIN.LOCAL --search "(LDAP QUERY)" --atributes ATTRIBUTE1,ATTRIBUTE2,ETC (Custom attributes from custom search)

### TIP: Can be used with "execute-assembly" with Cobalt Strike C2
