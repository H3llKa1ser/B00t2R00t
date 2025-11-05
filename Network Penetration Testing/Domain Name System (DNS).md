# Domain Name System (DNS)

## Port: 53

### 1) Nmap scan

    nmap --script dns-brute,dns-nsid,dns-recursion,dns-zone-transfer -p 53 IP

### 2) AD Domain enumeration via DNS

    nmap -p 53 --script "dns-nsid,dns-srv-enum" IP

### 3) Zone Transfer

    dig axfr domain.local @IP

### 4) Retrieve all records

    dig ANY domain.local @IP

### 5) Query any records

    nslookup
    > server DNS_IP
    > set type=any
    > domain.local

### 6) Reverse lookup

    dig -x IP

