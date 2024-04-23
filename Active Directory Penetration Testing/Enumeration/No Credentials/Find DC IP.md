Find Domain Controller IP Address (DC IP)

## Commands:

 - nmcli dev show eth0 (Show domain name and DNS)

 - nslookup -type=SRV _ldap._tcp.dc._msdcs.DOMAIN
