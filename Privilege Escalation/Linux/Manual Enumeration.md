# Manual Enumeration Commands

## PrivEsc resource: GTFOBINS https://gtfobins.github.io/

    Hostname = Check Hostname  
    uname -a = Check kernel info
    cat /proc/version = Check system proecsses info
    cat /etc/issue = Check message before login prompt
    env = Environmental Variables
    sudo -l = Users that can run sudo
    ps aux = show processes for all users (a) display tthe user that launchd the process (u)  show processes that are not attached to a terminal (x)
    ls -la = show all files, including hidden files in a lost with their permissions        
    id = User privilege level and group membership information
    cat /etc/passwd | cut -d ":" -f = Convert passwd file in a list for user enumeration
    History = Command histroy within host. Can also be shown in the .bash_history file of the current user.
    ifconfig /ip a = Network information of host
    arp -a = Routing table information
    find / -type f -perm -u=s 2>/dev/null = Search for binaries with SUID bit set
    find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u = Find writable folders/files by your current user.
