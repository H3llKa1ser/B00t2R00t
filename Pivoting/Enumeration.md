# Enumeration

## Ways to enumerate a network further:

#### 1: Materials found on the machine

#### 2: Pre-installed tools

#### 3: Statically compiled binaries

#### 4: Scripting Techniques

#### 5: Local tools through a proxy

### Routing table

    arp -a

### Domain names in Hosts files

    cat /etc/hosts 

    type C:\Windows\System32\drivers\etc\hosts

### DNS and network configuration

    cat /etc/resolv.conf (Linux)

    ipconfig /all (Windows)

    route print (Windows)

    ipconfig /displaydns | findstr "Record" | findstr "Name Host" (Windows DNS Entries)
