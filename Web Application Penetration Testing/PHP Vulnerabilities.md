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
