### CMS: Wordpress, Joomla

### Requirements: Administrator credentials

# WORDPRESS:

### Steps:

#### 1) On admin panel, go to: Themes -> Editor

#### 2) Choose the active theme of the site then edit 404.php file with a reverse shell

#### 3) Setup listener

#### 4) Go to the site and trigger the 404 error to run the modified php file to get a shell

    http://domain.local/wp-content/themes/twentyfifteen/404.php

Theme can be different

### Alternate usage: use exploit/unix/webapp/wp_admin_shell_upload

## MALICIOUS PLUGIN INSTALLATION ON WORDPRESS

#### 1) On admin panel, go to: plugins -> editor

#### 2) Install new plugin, then upload the zip file that contains the malicious plugin

#### 3) Setup listener

#### 4) On plugin menu, click activate the newly installed plugin to execute and get a shell

## ALTERNATE METHOD OF MALICIOUS PLUGIN

#### 1) On admin panel, go to: plugins -> Add New

#### 2) Select install/upload and use your php reverse shell

#### 3) If it asks you for FTP credentials and has FTP enabled, insert credentials and 127.0.0.1 hostname

#### 4) Go to media -> select our file -> Go to the presented URL that the file resides

#### 5) GG

# JOOMLA 

#### 1) On admin panel, go to: System -> extensions -> Site templates -> templates

#### 2) Find the active template of the site then edit the error.php file with a reverse shell

#### 3) Setup listener

#### 4) Go to the site and search for a page that doesn't exist to trigger the malicious payload and get a shell

 - curl -k "http://DOMAIN.LOCAL/templates/TEMPLETE_NAME/error.php/error"

