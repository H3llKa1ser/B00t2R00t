# SessionExec

This module will connect to the target system elevate to SYSTEM and run a specified -command as each user on the system that exhibits a logon session.

Output for  SessionExec is stored $PWD\PME\SCCM\.

# Usage

### SMB execution with password authentication, targeting workstations

    PsMapExec SMB -Module SessionExec -Targets "Workstations" -Username [User] -Password [Pass] -Command "whoami /all"

### WinRM execution with hash authentication, targeting servers

    PsMapExec WinRM -Module SessionExec -Targets "Servers" -Username [User] -Hash [Hash] -Command "whoami /all"

### WMI execution with Kerberos ticket authentication (Username not required)

    PsMapExec WMI -Module SessionExec -Targets "All" -Ticket [doI..] 

# Optional Parameters

### 1) The command to run as each user, if not specified a simple "whoami" will be executed.

    -Command

### 2) Displays each targets output to the console

    -ShowOutput

### 3) Display only successful results

    -SuccessOnly

# Supported Methods

1) SMB 

2) SessionHunter

3) WMI 

4) WinRM
