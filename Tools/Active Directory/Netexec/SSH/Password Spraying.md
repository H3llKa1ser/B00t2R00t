# Password Spraying (without bruteforce)

    nxc ssh 192.168.1.0/24 -u userfile -p passwordfile --no-bruteforce

### By default nxc will exit after a successful login is found. Using the --continue-on-success flag will continue spraying even after a valid password is found. Useful for spraying a single password against a large user list.

## TIP: You can also use Hydra available by default on Kali to bruteforce SSH password, it's faster and better 
