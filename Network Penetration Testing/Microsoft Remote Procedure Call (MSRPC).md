# Microsoft Remote Procedure Call (MSRPC)

## Port: 135

### 1) Nmap scan

    nmap -p 135 --script msrpc-enum IP

### 2) Impacket-rpcdump enumeration

    impacket-rpcdump IP -p 135

### 3) RPC over HTTP services enumeration

     nmap -p 593 --script http-rpc-epmap IP  

### 4) Rpcclient

Connect with a null session

    rpcclient -U "" -N IP

Connect to the target and list available shares

    rpcclient -U "" -N IP -c "srvinfo"

List all available users

    rpcclient -U "" -N IP -c "enumdomusers"

Domain groups enumeration

    rpcclient -U "" -N IP -c "enumdomgroups"

Query user information

    rpcclient -U "USERNAME" -W "DOMAIN" IP -c "queryuser USERNAME"

### Rpcclient commands

    enumdomusers
    enumdomgroups
    queryuser 0x450
    enumprinters
    querydominfo
    createdomuser
    deletedomuser
    lookupnames
    lookupsids
    lsaaddacctrights
    lsaremoveacctrights
    dsroledominfo
    dsenumdomtrusts

List Users

    enumdomusers

Get User Details

    queryuser 0xRID

Get User Groups

    queryusergroups 0xRID

Get User SID

    lookupnames USERNAME

Get User Aliases

    queryuseraliases [builtin|domain] SID

List Groups

    enumalsgroups BUILTIN|DOMAIN

Get Members of Alias

    queryaliasmem builtin|domain 0xRID

List Domains

    enumdomains

Obtain Domain SID

    lsaquery

Get Domain Information

    querydominfo

### 5) Brute force User/Password/SID

Nmap

    nmap --script smb-brute.nse -p 445 IP

Netexec

    netexec smb IP -u 'admin' -p wordlist_pass.txt

    netexec smb IP -u 'wordlist_user.txt' -p password

Lookup SID with Brute force (requires valid credentials and domain name)

    impacket-lookupsid domain.local/USER:domain.local@987@IP

### 6) Additional SID information

Find SID by Name

    lookupnames USERNAME

Find more SIDs

    lsaenumsid

Check RID Cycle for more SIDs

    lookupsids SID

### 7) Set User Info (Change Password)

    rpcclient -N IP -U 'USERNAME%PASSWORD' -c "setuserinfo2 TARGET_USERNAME 23 'NEW_PASSWORD'"

    rpcclient -U "" -N IP -c "setuserinfo2 USER 23 NEW_PASSWORD"

The setuserinfo function in rpcclient is used to modify user account information on a remote Windows system. The level parameter indicates the detail of information to modify or retrieve:


    Level 0: Basic info (username, full name).
    Level 1: Additional info (home directory, script path).
    Level 2: Further info (password age, privileges).
    Level 3: Detailed info (all above + group memberships).
    Level 4: Most detailed info (all above + SID).

To change a user's password, use setuserinfo2 with a level of 23. This level includes basic attributes and adds password management functionality. The setuserinfo function typically does not handle password changes directly; setuserinfo2 is preferred for this purpose.

