# Tunneling requests via h2c smuggling

## Tool: https://github.com/BishopFox/h2csmuggler

## Usage: python3 h2csmuggler.py -x HTTPS://IP_ADDRESS:PORT/ https://IP_ADDRESS:PORT/private

### When an HTTP/1.1 connection upgrade is attempted via some reverse proxies, they will directly forward the upgrade headers to the backend server instead of handling it themselves. The backend server will perform the upgrade and manage communications in the new protocol afterwards. The proxy will tunnel any further communications between client and server but won't check their contents anymore, since it assumes the protocol changed to something other than HTTP.

### Since connections in HTTP/2 are persistent by default, we should be able to send other HTTP/2 requests, which will now go directly to the backend server through the HTTP/2 tunnel. This technique is known as h2c smuggling.

### Note that for h2c smuggling to work, the proxy must forward the h2c upgrade to the backend. Some proxies are aware of h2c and could try to handle the connection upgrade themselves. In those cases, we would end up with a frontend connection upgraded to HTTP/2 instead of a direct tunnel to the backend, which wouldn't be of much use.
