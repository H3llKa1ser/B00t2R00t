# WinRM Authentication

## Testing Credentials

    nxc winrm 192.168.1.0/24 -u user -p password

## TIP: If the SMB port is closed you can also use the flag -d DOMAIN to avoid an SMB connection

    nxc winrm 192.168.1.0/24 -u user -p password -d DOMAIN
