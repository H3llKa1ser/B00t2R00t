# HTTP Browser Desync Attack

### In a Browser Desync attack, the attacker aims to take control of a victim's account by exploiting vulnerabilities in a web application's user connection system.

### This attack occurs in two steps:

#### 1) The initial request, appearing legitimate, is intended to disrupt the user request queue by introducing an arbitrary request. 

#### 2) Once the connection pool is compromised, the very next valid request will be replaced by the arbitrary request initiated in the previous step.

### Straightforward payload example:

fetch('http://MACHINE_IP:5000/', {    method: 'POST',    body: 'GET /redirect HTTP/1.1\r\nFoo: x',    mode: 'cors',})

### Write this JavaScript Payload in your browser command line that you can write JS

### Command breakdown:

#### 1) http://MACHINE_IP = This is the URL to which the HTTP request is made for the vulnerable server. In this case, it's the registration endpoint on the local server.

#### 2) { method: 'POST' } = The method parameter specifies the HTTP method for the request. Here, it's set to 'POST'.

#### 3) { body: 'GET /redirect HTTP/1.1\r\nFoo: x' } = In the body, there is the second request that is going to be injected into the queue.

#### 4) { mode: 'cors' } = This flag triggers an error when visiting the 404 web page and avoids following the redirect.




