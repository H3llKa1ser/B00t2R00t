# SMTP

PORT 25 (relying server to server) 465 (mail client to server)

You can send phishing email with this port to get reverse shell.

Used to send, receive, and relay outgoing emails and Main attacks are user enumeration and using an open relay to send spam

    nmap 192.168.10.10 --script=smtp* -p 25

Login with

    telnet IP 25
