# HTTP Request Smuggling through broken WebSocket tunnels

## Original research: https://github.com/0ang3el/websocket-smuggle

### To smuggle requests through a vulnerable proxy, we can create a malformed request such that the proxy thinks a WebSocket upgrade is performed, but the backend server doesn't really upgrade the connection. This will force the proxy into establishing a tunnel between client and server that will go unchecked since it assumes it is now a WebSocket connection, but the backend will still expect HTTP traffic.

### One way to force this is to send an upgrade request with an invalid Sec-Websocket-Version header. This header is used to specify the version of the WebSocket protocol to use and will normally take the value of 13 in most current WebSocket implementations. If the server supports the requested version, it should issue a 101 Switching Protocols response and upgrade the connection.

### But we aren't interested in upgrading the connection. If we send an unsupported value for the Sec-Websocket-Version header, the server will send a 426 Upgrade Required response to indicate the upgrade was unsuccessful

### Some proxies may assume that the upgrade is always completed, regardless of the server response. This can be abused to smuggle HTTP requests once again by performing the following steps:

#### 1) The client sends a WebSocket upgrade request with an invalid version number.

#### 2) The proxy forwards the request to the backend server.

#### 3) The backend server responds with 426 Upgrade Required. The connection doesn't upgrade, so the backend remains using HTTP instead of switching to a WebSocket connection.

#### 4) The proxy doesn't check the server response and assumes the upgrade was successful. Any further communications will be tunnelled since the proxy believes they are part of an upgraded WebSocket connection.

### It is important to note that this technique won't allow us to poison other users' backend connections. We will be limited to tunnelling requests through the proxy only, so we can bypass any restrictions imposed by the frontend proxy by using this trick.

## Steps to abuse:

#### 1) Find a resource that thr proxy denies access to.

#### 2) Burpsuite or OWASP ZAP

#### 3) Find the WebSocket endpoint (if it speaks WebSocket)

## Request: 

GET /socket HTTP/1.1
Host: IP_ADDRESS:PORT
Sec-WebSocket-Version: 777
Upgrade: WebSocket
Connection: Upgrade
Sec-WebSocket-Key: nf6dB8Pb/BLinZ7UexUXHg==

#### 4) Send to repeater

#### 5) Disable Update Content-Length to not break the attack

#### 6) Smuggle another HTTP request below the one we just created (The resource we want to access)

## Example: 

GET /socket HTTP/1.1
Host: IP_ADDRESS:PORT
Sec-WebSocket-Version: 777
Upgrade: WebSocket
Connection: Upgrade
Sec-WebSocket-Key: nf6dB8Pb/BLinZ7UexUXHg==



GET /RESOURCE HTTP/1.1
Host: IP_ADDRESS:PORT


## TIP: DON'T FORGET TO PRESS ENTER TWICE (ADD 2 NEWLINES UNDER THE PAYLOAD) AFTER THE SMUGGLED HTTP REQUEST TO MAKE THIS ATTACK WORK

#### 7) Send the request to access the restricted content

## What if the app doesn't speak WebSocket?

### Note that some proxies will not even require the existence of a WebSocket endpoint for this technique to work. All we need is to fool the proxy into believing we are establishing a connection to a WebSocket, even if this isn't true. Look at what happens if you try to send the following payload (be sure to add two newlines after the payload in Burp):

GET / HTTP/1.1
Host: 10.10.55.67:8001
Sec-WebSocket-Version: 13
Upgrade: WebSocket
Connection: Upgrade
Sec-WebSocket-Key: nf6dB8Pb/BLinZ7UexUXHg==

GET /flag HTTP/1.1
Host: 10.10.55.67:8001


### This payload should still work, even though the first request is directed to /, which is not a WebSocket-enabled endpoint. The proxy simply doesn't check the response from the upgrade, so you can use any payload that looks close enough to a WebSocket upgrade.

## NOTE: This payload will randomly fail when using Burp. You can either retry the payload a couple of times until it works, or deliver it by pasting it into a terminal running nc 10.10.55.67 8001, where it will work every time (don't forget the trailing newlines).

# Tricking the proxy that actually checks for the response code of the upgrade

### Since we can't just smuggle requests anymore, we need to find a way to trick the proxy into believing a valid WebSocket connection has been established. This means we need to somehow force the backend web server to reply to our upgrade request with a fake 101 Switching Protocols response without actually upgrading the connection in the backend.

### While we won't be able to do this for all applications, if our target app has some vulnerability that allows us to proxy requests back to a server we control as attackers, we might be able to inject the 101 Switching Protocols response to an arbitrary request. In these special cases, we should be able to smuggle requests through a fake WebSocket connection again.

### Example: You can abuse an SSRF vulnerability to create a fake webserver that only responds with status 101 to every request (101responseonly.py in scripts directory)

### Then Abuse the SSRF vulnerability by sending a request to your fake webserver, then smuggle an HTTP request to gain access to restricted resources (Like the above example, except that you have to abuse the SSRF vulnerability)

### Profit!
