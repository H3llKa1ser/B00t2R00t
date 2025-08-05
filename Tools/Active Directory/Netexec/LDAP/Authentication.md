# LDAP Authentication

### Testing if an account exists without kerberos protocol

    nxc ldap 192.168.1.0/24 -u users.txt -p '' -k

## Testing credentials

    nxc ldap 192.168.1.0/24 -u user -p password

     nxc ldap 192.168.1.0/24 -u user -H A29F7623FD11550DEF0192DE9246F46B

## Domain name resolution is expected!

### By default, the ldap protocol will get the domain name by making connection to the SMB share (of the dc), if you don't want that initial connection, just add the option --no-smb

