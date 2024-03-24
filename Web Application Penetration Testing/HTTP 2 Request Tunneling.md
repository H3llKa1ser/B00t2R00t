# HTTP/2 Request Tunneling

### So far, the attack vectors we have looked at depend on the backend server to reuse a single HTTP connection to serve all users. In certain proxy implementations, each user will get its own backend connection to separate their request from others. Whenever this happens, an attacker won't be able to influence the requests of other users. At first sight, it would appear that we can't do much if confined to our own connection, but we can still smuggle requests through the frontend proxy and achieve some results. Since we can only smuggle requests to our connection, this scenario is often called request tunnelling.

## Leaking Internal Headers

### The simplest way to abuse request tunnelling is to get some information on how the backend requests look. In some scenarios, the frontend proxies may add headers to the requests before sending them to the backend. If we want to smuggle a specific request to the backend, we may need to add such headers for the request to go through.

### To leak such headers, we can abuse any functionality in the backend application that reflects a parameter from the request into the response. In our case, the application reflects whatever data is sent to /hello through the q POST parameter.

### Most browsers will add this header to all HTTP/2 requests so that the backend will still receive a valid Content-Length header if an HTTP downgrade occurs. In the backend, the request would be converted into HTTP/1.1. 
