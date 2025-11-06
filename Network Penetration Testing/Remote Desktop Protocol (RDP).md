# Remote Desktop Protocol (RDP)

Port 3389

### 1) Nmap Scan

    nmap --script "rdp-enum-encryption,rdp-vuln-ms12-020,rdp-ntlm-info,rdp-banner" -p 3389 IP

### 2) Brute force

    hydra -L USER_LIST -P PASSWORD_LIST -s 3389 rdp://IP

### 3) Password Spray

    crowbar -b rdp -s IP/32 -U users.txt -C rockyou.txt
    netexec rdp IP -u users.txt -p rockyou.txt

### 4) Login 

Connect using xfreerdp with various options

    xfreerdp /cert-ignore /bpp:8 /compression /themes /wallpaper /auto-reconnect /h:1000 /w:1600 /v:IP /u:USERNAME /p:PASSWORD

Connect with a drive mapping and increased timeout

    xfreerdp /u:<username> /v:<IP> /cert:ignore /p:<password> /timeout:20000 /drive:<drive_name>,<local_path>

Connect with clipboard support and set resolution

    xfreerdp /compression +auto-reconnect /u:$USER/p:$PASSWORD /v:<ip> +clipboard /size:1920x1080 /drive:desktop,/home/$YOUR_USERNAME/Desktop

Connect using rdesktop with credentials

    rdesktop -u $USER -p $PASSWORD -g 1920x1080 <ip>

Connect using rdesktop without credentials

    rdesktop <ip>
