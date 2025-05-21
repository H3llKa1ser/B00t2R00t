# Wstunnel

Link: https://github.com/erebe/wstunnel

Pivot via WebSockets and HTTP/2

### OS

1) Linux

2) Windows

3) MacOS

## Standard socks proxy

### 1) Pivot machine

wstunnel server wss://[::]:8080

### 2) Attacker machine

    wstunnel client -L socks5://127.0.0.1:1080 wss://$PIVOT:8080

##### Example usage

    curl -x socks5h://127.0.0.1:8888 http://$TARGET

## Reverse socks proxy

### 1) Pivot machine

    wstunnel server wss://[::]:443

### 2) Attacker machine

    wstunnel client -R socks5://0.0.0.0:1080 wss://$ATTACKER:443

### 3) Apply config to proxychains file on attacker machine

    socks5    127.0.0.1 1080    

## Behind a proxy

In case the client is behind a proxy (for example, a corporate proxy), it can be passed to the client. For example, with the previous command:

    wstunnel client -R socks5://0.0.0.0:1080 wss://$ATTACKER:443 -p $USER:$PASS@$proxyURL:$PORT
