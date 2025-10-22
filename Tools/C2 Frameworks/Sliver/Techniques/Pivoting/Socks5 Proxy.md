# Socks5 Proxy

Select the session within sliver and then run the following - later configure /etc/proxychains.conf accordingly

    socks5 start

Verify /etc/proxychains4.conf

    [ProxyList]
    socks5  127.0.0.1   1081

Use proxychains4

    sudo proxychains -q netexec smb IP
