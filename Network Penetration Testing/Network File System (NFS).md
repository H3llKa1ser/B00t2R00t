# Network File System (NFS)

Port 2049

### 1) Nmap Scan

    nmap -p 2049 -sV --script "nfs-showmount,nfs-ls,nfs-statfs,nfs-secure,nfs-client,disk,nfs-*" IP

### 2) Enumeration

Show all NFS shares on the target

    showmount -e IP

Show mount information for the target

    showmount IP

### 3) Mounting

Create a local directory to mount the NFS share

    mkdir MOUNT

Mount the NFS share

    sudo mount -t nfs vers=<version>,nolock IP:SHARE MOUNT

    
