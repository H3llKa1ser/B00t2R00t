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
