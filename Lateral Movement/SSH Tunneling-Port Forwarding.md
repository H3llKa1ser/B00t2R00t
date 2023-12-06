# Forward connections

## Port forwarding command example:

#### ssh -L 8000:172.16.1.1:80 user@172.16.1.5 -fN

## The flags mean:

#### -L = Creates a link to a local port

#### -D PORT = Opens a port as a proxy

#### -fN = Backgrounds the shell then tells SSH that it doesn't need to execute any commands, only set up the connection.

## Proxying command example:

#### ssd -D PORT user@172.16.1.5 -fN

#### PORT should be available and configured in proxychains.
