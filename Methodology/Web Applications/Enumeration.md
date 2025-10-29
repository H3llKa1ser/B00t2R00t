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
    /usr/share/seclists/Discovery/Web-Content/raft-large-files.txt

Tools:

Ffuf

    ffuf -c -w /usr/share/seclists/Discovery/Web-Content/common.txt -u http://domain.local/FUZZ -fc 404,403

Feroxbuster

    feroxbuster --url http://domain.local -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt  -C 404,403

Then, based on the word count, size count, etc, filter for false positives.

### 6) Endpoint fuzzing 

Fuzz potentially vulnerable endpoints to discover vulnerabilities like LFI, SSRF, etc.

    ffuf -w /usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt -t 100 -u http://domain.local/secret/FUZZ.php

### 7) Parameter fuzzing

LFI

    ffuf -w /usr/share/seclists/Fuzzing/LFI/LFI-Jhaddix.txt -t 100 -u http://domain.local/secret/evil.php?FUZZ=/etc/passwd -fs 0

Authenticated fuzzing

    ffuf -c -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt  -t 100 -u http://domain.local/admin/dashboard.php?page=FUZZ -b "cookie=serdesfsefhijosefjtfgyuhjiosefdfthgyjh" -fs 293

## WHEN IN DOUBT, OPEN UP BURPSUITE. YOU CAN ALSO BRUTE-FORCE PARAMETERS WITH INTRUDER.

### 8) Vulnerability Scan (if all else fails and want to look for a vulnerability like Shellshock for example)

    nikto -h domain.local

### 9) After user enumeration via any means and want to brute-force, instead of using your usual wordlist, you can create custom wordlists if you find parts of the website that contain a lot of words that could be used in a wordlist

    cewl -w wordlist.txt http://domain.local
