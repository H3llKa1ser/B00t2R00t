# FTP

There is username and password on this you can upload shell on direcotry or find downloads files for initial access

#### 1) 

    nmap --script=ftp-* -p 21 $ip (scan complete FTP Port)

#### 2) check if anonymous allowed then use ftp anonymous@ip (password also anonymous)

#### 3) Active from passive

There is some mod if ls dir not work then apply use passive (to go in active mod).

#### 4) File Operations

    mget * (# Download everything from current directory like zip, pdf, doc)

    send/put (# Send single file or upload shell command)

#### ) After download files always use 

    exiftool –u -a <filename> (Meta description for users)

## TIP: ·FTP version above 3.0 not exploitable
