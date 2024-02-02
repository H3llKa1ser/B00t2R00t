### CMS: Wordpress, Joomla

### Requirements: Administrator credentials

# WORDPRESS:

### Steps:

#### 1) On admin panel, go to: Themes -> Editor

#### 2) Choose the active theme of the site then edit 404.php file with a reverse shell

#### 3) Setup listener

#### 4) Go to the site and trigger the 404 error to run the modified php file to get a shell

# JOOMLA 

#### 1) On admin panel, go to: extensions -> templates -> templates

#### 2) Find the active template of the site then edit the error.php file with a reverse shell

#### 3) Setup listener

#### 4) Go to the site and search for a page that doesn't exist to trigger the malicious payload and get a shell

