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

