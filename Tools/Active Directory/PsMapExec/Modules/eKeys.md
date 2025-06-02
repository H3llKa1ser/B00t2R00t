# eKeys

Executes Mimikatz's sekurlsa::ekeys on each target system to retrieve Kerberos encryption keys.

For each system output is stored in $pwd\PME\eKeys\

# Usage

# Standard execution

    PsMapExec [Method] -targets All -Module eKeys -ShowOutput

# Parsing 

PsMapExec will parse the results from each system and present the results in a digestable and readable format. The notes field will highlight in yellow any interesting information about each result.

The table below shows the possible values for the notes field.

| Value               | Description                                                                                             |
|---------------------|---------------------------------------------------------------------------------------------------------|
| AdminCount=1        | The parsed account has an AdminCount value of 1. This means the account may hold privileged access.     |
| rc4_hmac_nt=Empty Password | The rc4 value is equal to that of an empty password.                                             |
| Cleartext Password  | Cleartext password was parsed from the results. Highlighted only for user accounts, not computer accounts. |
| Domain Admin        | The account is a member of a high-value group.                                                          |
| Enterprise Admin    | The account is a member of a high-value group.                                                          |
| Server Operator     | The account is a member of a high-value group.                                                          |
| Account Operator    | The account is a member of a high-value group.                                                          |

# Optional Parameters

### 1) If specified, PsMapExec will not automatically parse output from all targets systems and identify accounts that belong to privileged groups. 

    -NoParse

### 2) Displays each targets output to the console

    -ShowOutput

### 3) Display only successful results

    -SuccessOnly

# Supported Methods

1) MSSQL 

2) SMB 

3) SessionHunter

4) WMI 

5) WinRM
