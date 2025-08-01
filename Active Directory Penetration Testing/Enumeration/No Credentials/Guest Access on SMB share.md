# List guess access on SMB share

## Tools: enum4linux , smbmap , smbclient , CrackMapExec/Netexec

## Commands:

    enum4linux -a -u "" -p "" DC_IP && enum4linux -a -u "guest" -p "" DC_IP (Null session and guest access enumeration)

    smbmap -u "" -p "" -P 445 -H DC_IP && smbmap -u "guest" -p "" -P 445 -H DC_IP

    smbclient-U '%' -L //DC_IP && smbclient -U 'guest%' -L //DC_IP

    netexec smb IP -u '' -p '' (Null session)

    netexec smb IP -u 'a' -p '' (Anonymous logon)
