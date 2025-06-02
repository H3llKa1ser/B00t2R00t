# Files

The Files module will enumerate non-default files within the home and primary directories for each accessible user on the remote system.

This can be used to help identify interesting files on each system for which may contain sensitive or credentialed information.

For each system output is stored in $pwd\PME\PME\User Files\

# Usage

### Standard execution

    PsMapExec [Method] -targets All -Module Files -ShowOutput

# Optional Parameters

### 1) Displays each targets output to the console

    -ShowOutput

### 2) Display only successful results

    -SuccessOnly

# Supported Methods

1) MSSQL 

2) SMB 

3) SessionHunter

4) WMI 

5) WinRM
