# Web App Enumeration Methodology

### 1) Check page source code for secret pages, plugin versions, interesting comments made by the developers, hidden subdomains, and interesting .js files.

Right-click on the page, then choose "View page source code"

In the page source code, press CTRL+F to use the search function and search for interesting comments.

    <!--

### 2) If we find a WordPress installation, use wpscan

    wpscan --url http://domain.local/wordpress -e ap

### 3) If we find an admin login portal, try default credentials like

    admin:admin
    admin:password
    admin:password123
    admin:password123456
    root:root
    root:toor

### 4) Check server version, web app technologies, and version using the Wappalyzer plugin, then search for vulnerabilities using Google or searchsploit.

For example

    searchsploit search "WordPress 5.5" 

### 5) Directory enumeration

Wordlists

    /usr/share/seclists/Discovery/Web-Content/common.txt
    /usr/share/wordlists/dirb/common.txt
    /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt

Tools:

Ffuf

    ffuf -c -w /usr/share/seclists/Discovery/Web-Content/common.txt -u http://domain.local/FUZZ -fc 404,403

Feroxbuster

    feroxbuster --url http://domain.local -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt  -C 404,403

Then, based on the word count, size count, etc, filter for false positives.
