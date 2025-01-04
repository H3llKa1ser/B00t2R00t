# Network Pivoting Methodology

## 1) Internal Host Discovery

### In a network, if you root a machine, do these checks:

## Windows

Info about interfaces

    ipconfig /all

Print available routes

    route print

Known hosts on the routing table

    arp -a

Opened ports/services/connections running on the machine

    netstat -ano

DNS Entries

    type C:\WINDOWS\System32\drivers\etc\hosts


And

    ipconfig /displaydns | findstr "Record" | findstr "Name Host"

Ping Sweep Script (You might have to do some guesswork on the subnet we want to discover if we did not find any data)

    (for /L %a IN (1,1,254) DO ping /n 1 /w 1 172.16.2.%a) | find "Reply"

#### Linux

Info about interfaces

    ip a

    ifconfig

Known hosts on the routing table

    arp -a

Opened ports/services/connections running on the machine

    netstat -ano

DNS Entries

    cat /etc/hosts

    cat /etc/resolv.conf

Ping Sweep Script (You might have to do some guesswork on the subnet we want to discover if we did not find any data)

    for i in {1..255};do (ping -c 1 172.16.2.$i | grep "bytes from"|cut -d ' ' -f4|tr -d ':' &);done
