### Essentially, a MUCH faster port scanner than Nmap. Also utilized NSE

## RUSTSCAN SCRIPTING ENGINE

#### 1) Python

#### 2) Shell

#### 3) Perl

#### 4) Any program which is a binary and in $PATH

## COMMANDS

#### rustscan -r PORTS -a TARGET_IP -- NMAP COMMANDS

#### CIDR Support = rustscan -a 1.1.1.1/24 

#### Host scanning = rustscan -a www.google.com

#### Random port Opening (Firewall Evasion) = rustscan -a 127.0.0.1 --range 1-1000 --sca-order "random"

#### -V = Rustscan version

#### -b = Select batch size

#### -t = Set timeout 

#### -q = Quiet mode

#### --ulimit 5000 = IMPORTANT! ALWAYS USE ON EVERY SCAN IF YOU GET ERRORS WITHOUT IT.
