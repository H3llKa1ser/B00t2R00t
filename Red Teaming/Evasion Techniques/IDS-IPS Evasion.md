### Tools: nmap, netcat/socat

# EVASION VIA PROTOCOL MANIPULATION

### 1) Relying on a different protocol

### 2) Manipulating (source) TCP/UDP Port

### 3) Using session splicing (IP Packet fragmentation)

### 4) Sending invalid packets

## 1st technique example

#### 1) nc -lvnp 25 (Gives the imp[ression that it is a usual TCP connection with an SMTP server)

#### Counter: Deep Packet Inspection (DPI)

#### 2) nc -ulvnp 162 (UDP Connection)

#### Counter: DPI

# 2nd Technique example

#### 1) nmap -sS -Pn -g 80 -F TARGET_IP (HTTP Server spoof)

#### 2) nmap -sU -Pn -g 53 -F TARGET_IP (DNS Server spoof)

#### 3) Can be used with netcat as well

# 3rd Technique example

### nmap options: 

#### -f = Set the data in IP packet to 8 bytes

#### -ff = To limit the data in the IP packet to 16 bytes at most

#### --mtu SIZE = Custom data size (Multiple of 8)

# 4th Technique example

### nmap options:

#### --badsum

#### --scanflags: URG ACK PSH RST SYN FIN (Custom TCP flag combinations)
