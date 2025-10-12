# SMB NetBIOS

PORT 139, port 445 (also PORT 137 (name services) & PORT 138 (datagam) UDP netbios)

Always check guest login and then check public share with write and execute permission and you will find credential, files pdf ps1 etc


    nmap -v -script smb-vuln* -p 139,445 10.10.10.10

    smbmap -H 192.168.10.10 (public shares) (check read write and execute)

    smbmap -H 192.168.10.10 -R tmp (check specific folder like tmp)

    enum4linux -a 192.168.10.10 (best command to find details and users list)

    smbclient -p 4455 -L //192.168.10.10/ -U noman --password=noman1234

    smbclient -p 4455 //192.168.10.10/scripts -U noman --password noman1234 (login)

