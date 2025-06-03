# SAM

Dumps SAM credentials for each target system

For each system output is stored in $pwd\PME\PME\SAM\

# Usage

##### Standard execution

    PsMapExec [Method] -targets All -Module SAM -ShowOutput

# Parsing

PsMapExec will parse the results from each system and present the results in a digestable and readable format. PsMapExec will display which systems are reusing SAM hashes and then display all collected hashes in a Hashcat friendly format.

The output appends the system name from which the hash has been pulled from to the name for easy identification. Even in this format, it is still a Hashcat friendly format.

# Optional Parameters

### 1) Will ommit parsing output from each system and checks for which SAM hashes are valid on multiple systems.

    -NoParse

### 2) When provided, collected SAM hashes will be compared against an online database https://ntlm.pw

    -Rainbow

### 3) Displays each targets output to the console

    -ShowOutput

### 4) Display only successful results

    -SuccessOnly

# Supported Methods

1) MSSQL 

2) SMB 

3) SessionHunter (WMI)

4) WMI 

5) WinRM
