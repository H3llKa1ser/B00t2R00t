## File transfer via SFTP protocol

### Clients: sftp, filezilla, winscp, scp

#### 1) 

    sftp USERNAME@IP_ADDRESS

#### 2) 

    put FILE.TXT

## Symlink abuse with SFTP

#### 1) Gives access to the root directory of the webserver

    symlink / file/root 

#### 2) View php files with symlink abuse

    symlink /var/www/html/index.php /directory/test.txt 
