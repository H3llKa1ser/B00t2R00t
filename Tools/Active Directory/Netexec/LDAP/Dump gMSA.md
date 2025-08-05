# Dump gMSA

## Extract gmsa credentials accounts

### Using the protocol LDAP you can extract the password of a gMSA account if you have the right.

## LDAPS is required to retrieve the password, using the --gmsa LDAPS is automatically selected

    $ nxc ldap <ip> -u <user> -p <pass> --gmsa
