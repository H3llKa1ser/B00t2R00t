# WinSCP

This module iterates through  the registry and identifies WinSCP session information, attempts to decrypt it and shows the plaintext session information.

For each system output is stored in $pwd\PME\PME\WinSCP\

# Usage

# Standard execution

    PsMapExec [Method] -targets All -Module WinSCP -ShowOutput

# Optional Parameters

### 1) Displays each target output to the console

    -ShowOutput

### 2) Display only successful results

    -SuccessOnly

# Supported Methods

1) MSSQL 

2) SMB 

3) SessionHunter (WMI)

4) WMI 

5) WinRM
