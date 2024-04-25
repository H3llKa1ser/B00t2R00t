# SSH Local Port Forwarding

### It is the method used in SSH to forward the ports of application from a client machine to the server machine. By making use of this, the SSH client listens for connections on a port which has been configured, and tunnels to an SSH server when a connection is received. This is how the server connects to a destination port which is configured and is present on a machine other than the SSH server.

 - ssh -L 8081:localhost:8080 -N -f -l USER TARGET_IP

# Forward connections

## Port forwarding command example:

#### ssh -L 8000:127.0.0.1:80 user@172.16.1.5 -fN

#### Use browser to navigate to internal app with 127.0.0.1:8000 (Example)

## The flags mean:

#### -L = Creates a link to a local port

#### -D PORT = Opens a port as a proxy

#### -fN = Backgrounds the shell then tells SSH that it doesn't need to execute any commands, only set up the connection.

## Proxying command example:

#### ssh -D PORT user@172.16.1.5 -fN

#### PORT should be available and configured in proxychains.

#### If you want to use a tool via proxy, use like:

#### proxychains nmap 127.0.0.1 -sT TARGET_IP (Example)
