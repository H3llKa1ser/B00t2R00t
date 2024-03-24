# HTTP Request Smuggling through broken WebSocket tunnels

### To smuggle requests through a vulnerable proxy, we can create a malformed request such that the proxy thinks a WebSocket upgrade is performed, but the backend server doesn't really upgrade the connection. This will force the proxy into establishing a tunnel between client and server that will go unchecked since it assumes it is now a WebSocket connection, but the backend will still expect HTTP traffic.

### One way to force this is to send an upgrade request with an invalid Sec-Websocket-Version header. This header is used to specify the version of the WebSocket protocol to use and will normally take the value of 13 in most current WebSocket implementations. If the server supports the requested version, it should issue a 101 Switching Protocols response and upgrade the connection.

### But we aren't interested in upgrading the connection. If we send an unsupported value for the Sec-Websocket-Version header, the server will send a 426 Upgrade Required response to indicate the upgrade was unsuccessful

### Some proxies may assume that the upgrade is always completed, regardless of the server response. This can be abused to smuggle HTTP requests once again by performing the following steps:

#### 1) The client sends a WebSocket upgrade request with an invalid version number.

#### 2) The proxy forwards the request to the backend server.

#### 3) The backend server responds with 426 Upgrade Required. The connection doesn't upgrade, so the backend remains using HTTP instead of switching to a WebSocket connection.

#### 4) The proxy doesn't check the server response and assumes the upgrade was successful. Any further communications will be tunnelled since the proxy believes they are part of an upgraded WebSocket connection.

### It is important to note that this technique won't allow us to poison other users' backend connections. We will be limited to tunnelling requests through the proxy only, so we can bypass any restrictions imposed by the frontend proxy by using this trick.

