# Update Password via MySQL CLI

### 1) Wordpress DB

    UPDATE wp_users SET user_pass = MD5('PASSWORD_HERE') WHERE user_login = 'admin';

### 2) Generic MySQL database

    UPDATE TABLE_NAME SET password = 'PASSWORD_HERE' WHERE username = 'admin';

### 3) Create a new user in the DB as well as the Linux system

Generate a password depending on the format it is being saved in the DB

    echo "{md5}"`echo -m "testpass" | openssl dgst -binary -md5 | openssl enc -base64`

Create user

    INSERT INTO `table_name` (`id`, `userid`, `passwd`, `uid`, `gid`, `homedir`, `shell`, `count`) VALUES (NULL, 'myuser', '{md5}F5rUXGziy5fPECniEgRugQ==', '1000', '1000', '/', '/bin/bash', '0');
