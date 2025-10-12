# SNMP

Port 161 UDP:

This will give you the username password or any hint for login


It will get with autorecon (UDP Port)

    nmap -sU -p161 --script "snmp-*" $ip

    nmap -n -vv -sV -sU -Pn -p 161,162 –script=snmp-processes,snmp-netstat IP

    snmpwalk -v 1 -c public 192.168.10.10 NET-SNMP-EXTEND-MIB::nsExtendOutputFull (this is command I have used in 2 3 machine to find username, password, or hint of user and pass

    evil-winrm -I 192.168.10.10 -u ‘noman’ -p ‘nomanpassword’ (login with this command)
