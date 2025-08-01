# Proxychains

### Usage:

     proxychains nmap -A -Pn INTERNAL_IP (Example)

## Master config file: /etc/proxychains.conf

#### If performing an Nmap scan through proxychains, comment out proxy_dns line (#).

#### Also we only do TCP scans through proxychains so use the -Pn switch always.

#### Use nmap through a proxy using the NSE (Nmap Scripting Engine)

#### You can set any type of proxy (SOCKS5/SOCKS5, etc) in the proxylist section of the file.

## PROTIP: If you want to use multiple SOCKS proxies with proxychains, do these steps:

### 1) Copy the master config file of proxychains to your working directory

    sudo cp /etc/proxychains.conf .

### 2) In the config file, add a SOCKS proxy with a DIFFERENT PORT than the original file, and rename the file with the port number for clarification (proxychains_1088.conf)

#### Example:

Master config file (proxychains.conf)

    socks5 127.0.0.1 1080

Duplicate config file (proxychains_1088.conf)

    socks5 127.0.0.1 1088

### 3) Run tools via proxychains using the second proxy you just set up

#### Example:

    proxychains -q -f ./proxychains_1088.conf netexec smb TARGET_IP

### You can repeat the same steps if you configure a 3rd proxy and so on, so forth
