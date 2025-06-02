# ConsoleHistory

Enumerates for and reads the ConsoleHost_history.txt file within each accessible user directory. This file can often contain credentialed information that has been stored within the terminal.

For each system output is stored in $pwd\PME\PME\Console History\

# Usage

###  Standard execution

    PsMapExec [Method] -targets All -Module ConsoleHistory -ShowOutput

# Supported Methods

1) MSSQL 

2) SMB 

3) SessionHunter

4) WMI 

5) WinRM
