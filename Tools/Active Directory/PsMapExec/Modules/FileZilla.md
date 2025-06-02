# FileZilla

This module iterates through each users %APPDATA% folder on the target host and identifies files associated with FileZilla that often store credentials such as:

%AppData%\FileZilla\sitemanager.xml

%AppData%\FileZilla\recentservers.xml

Any discovered credentials will be decoded to the plaintext value if not encrypted by a master password.

For each system output is stored in $pwd\PME\PME\FileZilla\

# Usage

### Standard execution

    PsMapExec [Method] -targets All -Module FileZilla -ShowOutput

# Optional Parameters

### 1) Displays each target output to the console

    -ShowOutput

### 2) Display only successful results

    -SuccessOnly

# Supported Methods

1) MSSQL 

2) SMB 

3) SessionHunter

4) WMI 

5) WinRM
