# Process Injection (Pi Module)

## You need at least local admin privilege on the remote target!

### The "pi" module accesses the process of a user with an active session on a Windows system using the Process Injection method to execute commands with the privileges of the target user (requires SYSTEM privileges).

### It allows impersonating authorized domain users in Active Directory.

### It works more stable for Server 2016/Win10 and above.

#### #~ NetExec <IP> -u username -p password -M pi -o PID=<target_process_pid> EXEC=<command>
