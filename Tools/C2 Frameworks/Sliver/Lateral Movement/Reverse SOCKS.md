# Reverse SOCKS

### Sliver supports two types of SOCKS5 proxies, an "in-band" proxy that tunnels though any C2 protocol, and WireGuard SOCKS proxy (only available when using WireGuard C2).

# In-band SOCKS5

### An in-band reverse SOCKS5 proxy is supported in Sliver versions 1.5 and later. Note that the SOCKS proxy feature can only be used on sessions (i.e., interactive sessions) and not beacons.

#### 1) socks5 add

### Simply upstream to 127.0.0.1:1081 from here, see socks5 add --help for more options.

# Wireguard SOCKS5

### In order to use wg-socks you'll need a WireGuard client, any client should work. However, we recommend using wg-quick, which is included in the wireguard-tools package available on most platforms (see WireGuard for more platforms):

#### 1) MacOS

 - brew install wireguard-tools

#### 2) Ubuntu/Kali

 - sudo apt install wierguard-tools

### First generate a WireGuard C2 implant (using generate --wg), and then start a WireGuard listener:

#### 1) wg

### Next, using Sliver you can create WireGuard client configuration using the wg-config command (you can use --save to write the configuration directly to a file):

#### 2) wg-config

### The only thing in the configuration file you'll need to change is the Endpoint setting, configure this to point to the Sliver server's WireGuard listener, and ensure to include the port number (by default UDP 53). Generally this will be the same value you specified as --lhost when generating the binary.

### Make sure your WireGuard listener is running and connect using the client configuration:

#### 3) wg-quick up wireguard.conf

### Now that your machine is connected to the Sliver WireGuard listener, just wait for an implant to connect:

### Interact with the session, and use wg-socks to create a SOCKS proxy!

