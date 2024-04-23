# Find user list

## Tools: enum4linux , CrackMapExec/Netexec , net , nmap, OSINT , kerbrute

## Commands:

 - enum4linux -U DC_IP | grep 'user:'

 - netexec smb IP --users

 - net rpc group members 'Domain Users' -W 'DOMAIN' -I IP -U '%'

 - nmap -p 88 --script=krb5-enum-users --script-args="krb5-enum-users.realm='DOMAIN'.userdb=USER_LIST_FILE" IP

 - kerbrute userenum USERS_LIST_FILE DOMAIN DC_IP

## If we find valid users, we can use more techniques with that name to gian further access within the network
