# NTDS

Executes Mimikatz's lsadump::dcsync on the target system. Parses the NTDS file to replicate Secretsdump output. No files are created on disk on the target system.

Output for each system is stored in $pwd\PME\DCSync\DCSync_Full_Dump

# Usage

# Standard execution

    PsMapExec [Method] -targets "DC01.Security.local" -Module NTDS -ShowOutput

# Parsing

PsMapExec will parse the results from the NTDS output and present them in a digestable and usable format.

# Optional Parameters

### 1) Will ommit parsing output from the method. Will Simply extract the NTDS file in a hashcat friendly format

    -NoParse

### 2) When provided, collected hashes will be compared against an online database https://ntlm.pw

    -Rainbow

### 3) Displays each targets output to the console

    -ShowOutput

### 4) Display only successful results

    -SuccessOnly

# Supported Methods

1) MSSQL 

2) SMB 

3) SessionHunter

4) WMI 

5) WinRM
