# EVASION VIA CONTROLLING THE SOURCE MAC/IP/PORT

### Tool: nmap

### Nmap can spoof:

### 1) Decoy(s)

### 2) Proxy

### 3) Spoof MAC address

### 4) Spoofed Source IP Address

### 5) Fixed Source port number

## DECOY

### Example:

#### nmap -sS -Pn -D RANDOM,RANDOM,OUR_IP -F TARGET_IP

### TIP: You can explicitly specify the random IPs in your scan

## PROXY

### Example:

#### nmap -sS -Pn --proxies PROXY_URL -F TARGET_IP

### TIP: You can chain proxies using a comma separated list

## SPOOFED MAC ADDRESS

#### nmap option: --spoof-mac MAC_ADDRESS

### MAC Spoofing works only if your system is on the same network segment as the target host

## SPOOFED IP ADDRESS

#### nmap option: -S IP_ADDRESS

### TIP: IP Spoofing can be useful if your system is on the same subnetwork as the target host. Also you can use this technique when you control a system that has a particular IP address

## FIXED SOURCE PORT NUMBER

### Example:

#### nmap -sS -Pn -g 8080 -F TARGET_IP

### TIP: Use port number like 53,80,8080,etc

