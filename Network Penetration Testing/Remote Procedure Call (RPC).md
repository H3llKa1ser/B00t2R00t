# Remote Procedure Call (RPC)

## Port: 111

### 1) Nmap scan

    nmap -sV -p 111 --script=rpcinfo IP

### 2) Discover RPC Services

    rpcinfo -p IP

    showmount -e IP
