## Program to use: pspy https://github.com/DominicBreuker/pspy

### cat /etc/crontab

#### If we have write permissions on the script, we can modify it to enter a reverse shell in it that will automatically run as root.

### Reverse shell source:  Revshells https://revshells.com/

#### Open a listener then wait. 

#### Example: nc -lvnp PORT

### If the full path of the script is not defined in the cronjob, then we can create our own script with the same name and run based on the PATH variables in the /etc/crontab file.

### We can also abuse wildcards for certain cronjobs to gain root.
