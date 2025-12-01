# File Transfer Protocol (FTP)

## Port 21

### 1) Nmap Detailed Scan

    nmap --script ftp-anon,ftp-bounce,ftp-libopie,ftp-proftpd-backdoor,ftp-vsftpd-backdoor,ftp-vuln-cve2010-4221,tftp-enum -p 21 IP

### 2) Anonymous Credentials login

    anonymous:anonymous

### 3) Upload test file to check for reflection on an HTTP port

    put test.txt

### 4) Upload binaries

    ftp> binary

    ftp> put BINARY_FILE

### 5) Download files

    wget -r ftp://USER:PASSWORD@IP/

### 6) Brute force attack 

    hydra -l USERNAME -P /usr/share/wordlists/rockyou.txt IP -t 4 ftp

### 7) Default FTP credentials brute force attack

    hydra -C /usr/share/wordlists/seclists/Passwords/Default-Credentials/ftp-betterdefaultpasslist.txt IP ftp

### 8) FTP important/sensitive files

    /etc/proftpd/proftpd.conf
    /etc/proftpd/sql.conf
