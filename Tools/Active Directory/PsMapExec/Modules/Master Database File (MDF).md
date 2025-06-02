# Master Database File MDF

This module creates a Volume Shadow Copy of the running MSSQL database, allowing the master.mdf file to be safely copied even while in use. It then extracts the login password hashes found within the master database ready to be cracked with hashcat.

# Usage

##### Standard execution

    PsMapExec [Method] -targets All -Module MDF -ShowOutput

# Optional Parameters

### 1) Displays each targets output to the console

    -ShowOutput

### 2) Display only successful results

    -SuccessOnly

# Supported Methods

1) SMB

2) SessionHunter 

3) WMI

4) WinRM
