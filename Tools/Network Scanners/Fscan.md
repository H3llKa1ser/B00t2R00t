# Fscan

## Link: https://github.com/shadow1ng/fscan/tree/main

### Usage

#### 1) Basic full range port scan

    fscan -h IP -p 1-65535

#### 2) Port scan using a proxy

    fscan -h IP -socks5 127.0.0.1:1080 -p 1-65535 
