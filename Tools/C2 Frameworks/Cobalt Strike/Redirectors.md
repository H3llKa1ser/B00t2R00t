# Redirectors

### A redirector is a system that sits between your target’s network and your team server. Any connections that come to the redirector are forwarded to your team server to process. A redirector is a way to provide multiple hosts for your Beacon payloads to call home to. A redirector also aids operational security as it makes it harder to trace the true location of your team server.

### Cobalt Strike’s listener management features support the use of redirectors. Simply specify your redirector hosts when you setup an HTTP or HTTPS Beacon listener. Cobalt Strike does not validate this information. If the host you provide is not affiliated with the current host, Cobalt Strike assumes it’s a redirector.One simple way to turn a server into a redirector is to use socat.

### Here’s the socat syntax to forward all connections on port 80 to the team server at 192.168.12.100 on port 80:

 - socat TCP4-LISTEN:80,fork TCP4:192.168.12.100:80
