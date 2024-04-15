# Port Forwarding

### Sliver provides two mechanisms for port forwarding to tunnel additional connections / tools into the target environment via an implant:

#### 1) portfwd

 - This command (available on all C2s) uses Sliver's in-band tunnels to transfer data between your local machine and the implant network (i.e., if you're using HTTP C2 all port forwarded traffic is tunneled over HTTP, same for mTLS/DNS/etc.)

#### 2) wg-portfwd

 - This command uses WireGuard port forwarding, and is only available when using WireGuard C2.

## NOTE: Generally speaking wg-portfwd is faster and more reliable, we recommend using it whenever possible. Some protocols may be unstable, or may not work when tunneled via portfwd. However, wg-portfwd does requires a little extra setup (see below).

# In-Band Tunneled Port Forwarding

### Tunneled port forwarding can be done over any C2 transport, and should work out of the box. Interact with the session you'd like to port forward through and use the portfwd add command:

#### 1) portfwd add --remote REMOTE_IP:REMOTE_PORT

### By default all port forwards will be bound to the 127.0.0.1 interface, but you can override this using the --bind flag. Port forwarding also works in multiplayer mode and will forward ports to your local system.

## Reverse Port Forwsrding

### As of v1.5.27 Sliver also supports reverse port forwarding via the rportfwd command.

# Wireguard Port Forwarding

### In order to use wg-portfwd you'll need a WireGuard client, any client should work. However, we recommend using wg-quick, which is included in the wireguard-tools package available on most platforms (see WireGuard for more platforms):

#### 1) MacOS

 - brew install wireguard-tools

#### 2) Ubuntu/Kali

 - sudo apt install wireguard-tools

### First generate a WireGuard C2 implant (using generate --wg), and then start a WireGuard listener:

#### 1) wg

#### 2) jobs

### Next, using Sliver you can create WireGuard client configuration using the wg-config command (you can use --save to write the configuration directly to a file):

#### 3) wg-config

### The only thing in the configuration file you'll need to change is the Endpoint setting, configure this to point to the Sliver server's WireGuard listener, and ensure to include the port number (by default UDP 53). Generally this will be the same value you specified as --lhost when generating the binary.

### Make sure your WireGuard listener is running and connect using the client configuration:

 - wg-quick up qireguard.conf

### Now that your machine is connected to the Sliver WireGuard listener, just wait for an implant to connect:

### Interact with the session, and use wg-portfwd add to create port forwards:

 - wg-portfwd add --remote REMOTE_IP:REMOTE_PORT

### You can now connect to 100.64.0.17:1080 via your WireGuard interface and the connection will come out at 10.10.10.10:3389!

