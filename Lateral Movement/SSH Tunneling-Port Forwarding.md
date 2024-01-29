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
