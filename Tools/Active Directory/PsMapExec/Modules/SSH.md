# SSH

Connects to the remote system and looks for SSH keys and known hosts within each user folder within .ssh Collected information is automatically parsed and organized where it will be stored in $PWD\PME\SSH\

# Usage

### SMB execution with password authentication, targeting workstations

    PsMapExec SMB -Targets "Workstations" -Username [User] -Password [Pass] -Module SSH

### WinRM execution with hash authentication, targeting servers

    PsMapExec WinRM -Targets "Servers" -Username [User] -Hash [RC4/AES256/NTLM] -Module SSH

### WMI execution with Kerberos ticket authentication (Username not required)

    PsMapExec WMI -Targets "All" -Ticket [doI..] -Module SSH

# Optional Parameters

### 1) Will ommit parsing output from each system.

    -NoParse

### 2) Displays each targets output to the console

    -ShowOutput

### 3) Display only successful results

    -SuccessOnly

# Supported Methods

1) SMB

2) SessionHunter

3) WMI

4) WinRM
