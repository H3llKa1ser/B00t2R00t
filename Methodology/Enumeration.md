# Enumeration Methodology

### 1) Low Hanging Fruits

1) Check for anonymous access for FTP and SMB protocols

If yes, then grab any files you find within the network share or FTP folder

2) Check protocol/application version for possible public RCE or similar exploit (Example: EternalBlue)

3) Within a web page, check the page source for any comments that might have been left out (<!--) or interesting files that we might encounter

They may contain credentials, etc

### 2) Directory Fuzzing

Enumerate the directories of a webserver to check for admin pages, specific application directories, etc to further discover the webapp

You can also enumerate other interesting files like .txt, .conf or .php 

Wordlists to use: 

1) common.txt

2) directory-list-2.3-medium.txt

        feroxbuster -u http://DOMAIN.LOCAL/ -w /usr/share/wordlists/dirb/common.txt -C 404 -x txt

### 3) Subdomain/Vhost Fuzzing

Enumerate vhosts of the machine to discover another attack surface

Use the filters for false positives

Wordlists to use:

DNS-Subdomains-top-1million-11000.txt

        ffuf -c -w /usr/share/wordlists/seclists/Discovery/DNS/Subdomains-top-1million-11000.txt -u http://domain.local/ -H 'Host: FUZZ.local.local' -fs NUM

If port 53 (DNS) is open, you can attempt to do a zone transfer to dump all DNS entries from a host

        dig axfr TARGET_IP

### 4) CMS Enumeration

If we find a wordpress installation on the server, use wpscan tool to scan for information.

You can also conduct attacks with wpscan like bruteforce if we have a valid user.

Same methodology works with other CMS as well like Joomla and Drupal

    wpscan --url http://domain.local/

### 5) Sensitive data from important files

        cat /var/www/html/wp-config.php

        strings FILE | grep -i password

### 6) Password reuse

Sometimes, when we uncover credentials, they may be reused on other applications as well.

Use credentials for admin pages, SSH, FTP, SMB, MySQL
