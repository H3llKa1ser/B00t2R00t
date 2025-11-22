# FTP

### 1) Linux FTP server with anonymous access

Attacker

    python3 -m pyftpdlib -p 21 -u anonymous -P anonymous

Target

#### Download single file
    
    wget ftp://username:password@ftp.example.com/path/to/file.txt

##### Download entire directory recursively

    wget -r ftp://username:password@ftp.example.com/directory/

##### Download anonymously

    wget ftp://ftp.example.com/file.txt

##### Download file

    curl -u username:password ftp://ftp.example.com/file.txt -o localfile.txt

##### List directory contents

    curl -u username:password ftp://ftp.example.com/directory/
