## Requirements: Possibly a crontab that runs apt as root or the user can run apt/apt-get runs as root with sudo

### Steps:

#### 1) APT::Update::Pre-Invoke {"/bin/bash /tmp/pwn.sh"} (Create a malicious config file (pwnapt) that calls your reverse shell script)

#### 2) Create a reverse shell file (pwn.sh)

#### 3) Upload the config file to the /etc/apt/apt.conf.d/00pwn via any method you can (FTP,tftp,etc)

#### 4) Setup listener

#### 5) GG!

### BONUS!

### Apt configuration files directory: /etc/apt/sources.list.d/
