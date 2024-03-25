# HTTP/2 Request Tunneling

### So far, the attack vectors we have looked at depend on the backend server to reuse a single HTTP connection to serve all users. In certain proxy implementations, each user will get its own backend connection to separate their request from others. Whenever this happens, an attacker won't be able to influence the requests of other users. At first sight, it would appear that we can't do much if confined to our own connection, but we can still smuggle requests through the frontend proxy and achieve some results. Since we can only smuggle requests to our connection, this scenario is often called request tunnelling.

## Leaking Internal Headers

### The simplest way to abuse request tunnelling is to get some information on how the backend requests look. In some scenarios, the frontend proxies may add headers to the requests before sending them to the backend. If we want to smuggle a specific request to the backend, we may need to add such headers for the request to go through.

### To leak such headers, we can abuse any functionality in the backend application that reflects a parameter from the request into the response. In our case, the application reflects whatever data is sent to /hello through the q POST parameter.

### Most browsers will add this header to all HTTP/2 requests so that the backend will still receive a valid Content-Length header if an HTTP downgrade occurs. In the backend, the request would be converted into HTTP/1.1. 

## Steps:

#### 1) Burpsuite

#### 2) Send to repeater

#### 3) Set Content-Length to 0

#### 4) Delete Body Content

#### 5) Disable Update Content-Length (Click on the gear next to send)

#### 6) Create a custom HTTP Header (Example: Foo: bar)

#### 7) Send the request 

#### 8) In the inspector, click on the arrow beside our custom header and edit it to our desired value.

#### 9) To do CRLF injection in the header value, press SHIFT+ENTER

#### 10) Apply changes, then the request pane will go blank and show you a message indicating the request is "kettled". This means that there's no way to represent the request in pure text anymore because of the special characters it contains (CRLFs in our case). From now on, all modifications to the request shall be done through the Inspector only.

#### 11) When the request is ready, you can press the Send button as usual to send it. Remember that our HTTP/2 request will be split into two backend requests, so the first time you send it, you will only obtain the response of the first request, which is empty. To get the value of the hidden internal headers, you will need to send the same request twice in quick succession. If all goes well, the website should reflect the internal headers to you on the second request

## Bypassing Frontend Restrictions

### In some scenarios, you will find that the frontend proxy enforces restrictions on what resources can be accessed on the backend website. For example, imagine your website has an admin panel at /admin, but you don't want it accessible to everyone on the Internet. As a simple solution, you could enforce a restriction in the frontend proxy to disallow any attempt to access /admin without requiring any changes in the backend server itself.

### A request tunnelling vulnerability would allow us to smuggle a request to the backend without the frontend proxy noticing, effectively bypassing frontend security controls.

### Another way to understand the attack, would be to say that we are using an allowed resource, in this case /hello, to smuggle a request to a forbidden resource, in this case /admin. From the point of view of the proxy, only a request for /hello was made, so no violations to the ACL were made. It is important to note that the resource we request via HTTP/2 must be allowed by the ACL for this attack to work. We are effectively smuggling an invalid request over a valid one. This same method can sometimes be used to smuggle request past Web Application Firewalls (WAF).

### Example:

POST /legit HTTP/2
Host: IP_ADDRESS:PORT
User-Agent: Mozilla/5.0
Foo: bar

#### Send request through repeater

#### Edit the Foo header from the inspector tab

bar\r\n
Host: IP_ADDRESS:PORT\r\n
Content-Length: 0\r\n
\r\n
GET /smuggled HTTP/1.1\r\n
X-Fake: a 
