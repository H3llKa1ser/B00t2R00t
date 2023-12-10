# NETWORK MAPPER (NMAP)

## FLAGS/SWITCHES

####  -Pn = Skip host discovery (No Ping scan)

#### -O = Enable OS Detection

#### -sC = Using default scripts from Nmap Scripting Engine (NSE)

### -sV = Version Detection

### -A = Aggressive scan (-sV -O -sC) 

## SCAN TECHNIQUES

#### --scanflags FLAGS = Customize TCP scan flags

#### -sS = TCP Stealth scan (SYN)

#### -sT = TCP Connect scan (3-way handshake)

#### -sA = TCP ACK scan (This technique is used to help gain information about Firewalls or IDS. Also it is NOT used to scan for ports.)

#### -sW = TCP Window scan

#### -sM = TCP Maimon scan

#### -sY = SCTP INIT scan

#### -sU = UDP scan

#### -sN = TCP Null scan

#### -sF = TCP FIN scan

### -sX = Xmas scan (Works only against Linux based machines)

### -b = FTP Bounce scan

## TIPS AND TRICKS:

### ACK scan can be a better option to scan a host machine

### Stealth scan (SYN) can blend better for scanning SERVERS

### By default, Nmap scans the top 1000 commonly used ports.

### Fast scans (-F) may scan fewer ports, but generates less traffic.

## MORE FLAGS/SWITCHES

#### -T 0-5 = Speed of the scanning process (Default speed is 3). (0 is very slow and 5 is very fast)

## TIP: 0 and 1 can avoid IDS. 2 uses less target machine resources.

### The slower the speed, the more accurate the scan becomes.

## FIREWALL EVASION/SPOOFING

#### --data-length NUM = Appends random data to the packets to avoid IDS solutions.

#### -f(f) --mtu VALUE = Fragment packets (divisive by 8 ) to avoid firewall solutions.

#### -D DECOY_IP DECOY_IP MY_IP DECOY_IP TARGET_IP = IP spoofing scan

#### --proxies = Relay connections through SOCKS4/5 proxies (E.g. proxychains)

#### -g Use given source port number

# NMAP SCRIPTING ENGINE (NSE)

#### -sC = Default NSE scripts (Useful for discovery and safe)

#### --script = Scanb with a single script

#### --script=INSERT_SCRIPT*= Wildcard

## PORT SPECIFICATION

#### -p NUM = Port scan for port NUM

#### -p NUM-NUM = Port range

#### -p U:53,T:21-25,80 = Port scan multiple TCP and UDP ports

#### -p http = scan from service name

#### -F = Fast port scan (100 ports)

#### --top-ports NUM = Scan the top NUM ports

## HOST DISCOVERY

#### -sn = Host Discovery Only

#### -Pn = Disable host discovery, port scan only

#### -n = Never do DNS resolution

#### -PR IP/SUBNET = ARP Discovery on local network 

#### -PU IP/SUBNET = UDP Discovery on port NUM

#### -PA IP/SUBNET = TCP ACK Discovery on port NUM

#### -PS IP/SUBNET = TCP SYN Discovery on port NUM

#### -sL = List scan

#### -PE/PP/PM = ICMP echo,timestamp,netmask request discovery.

#### -PO = IP protocol ping

#### --traceroute = Trace hop path to each host (Network Mapping)

# NMAP Scan phases

### 1) Script pre-scanning

### 2) Target enumeration (Passing IPs is faster than FQDN)

#### 3) Host discovery

#### 4) Reverse DNS resolutions

#### 5) Port scanning

#### 6) Version detection

#### 7) OS Detection

#### 8) Traceroute

#### 9) Script scanning

#### 10) Output

#### 11) Script post-scanning

# NMAP PORT STATES

### 1) Open

### 2) Closed

### 3) Filtered

### 4) Unfiltered

### 5) Open|Filtered

### 6) Closed|Filtered

### Open = A port accepts a TCP connection/UDP packet

### Closed = The device with a closed port doesn't listen for connections

### Filtered = Nmap can't determine if it is open or not due to packet filtering preventing probes from reaching it. (Firewall rules, router rules, etc)

### Unfiltered = Nmap can't determine if it is open or not, but it is sort of accessible nonetheless.
