# Update Password via MySQL CLI

### 1) Wordpress DB

    UPDATE wp_users SET user_pass = MD5('PASSWORD_HERE') WHERE user_login = 'admin';

### 2) Generic database

    UPDATE TABLE_NAME SET password='PASSWORD_HERE' WHERE username='admin';

