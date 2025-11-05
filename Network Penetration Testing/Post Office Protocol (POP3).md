# Post Office Protocol (POP3)

## Port: 110

### 1) Nmap scan

    nmap --script "pop3-capabilities or pop3-ntlm-info" -sV -p 110 IP

### 2) Connect

    telnet IP 110

### 3) Log in with a user

    USER USERNAME
    PASS PASSWORD

### 4) List all messages

    LIST

### 5) Retrieve the first email

    RETR 1

### 6) Brute force

    hydra -l USER -P /usr/share/wordlists/rockyou.txt IP pop3 
