# Memcached

Port: 11211 UDP

Tool: memcached-cli https://github.com/pd4d10/memcached-cli

### Steps

#### 1) Nmap scan

    sudo nmap RHOST -p 11211 -sU -sS --script memcached-info

#### 2) Install memcached-cli

    npm install -g memcached-cli

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
