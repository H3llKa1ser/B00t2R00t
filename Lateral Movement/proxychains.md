### Usage:

#### proxychains nmap -A -Pn 172.16.1.1 (Example)

## Master config file: /etc/proxychains.conf

#### If performing an Nmap scan through proxychains, comment out proxy_dns line (#).

#### Also we only do TCP scans through proxychains so use the -Pn switch always.

#### Use nmap through a proxy using the NSE (Nmap Scripting Engine)

#### You can set any type of proxy (SOCKS5/SOCKS5, etc) in the proxylist section of the file.
