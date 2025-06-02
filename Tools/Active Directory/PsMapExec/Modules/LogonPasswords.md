# LogonPasswords

Executes Mimikatz's sekurlsa::logonpasswords on the target system.

Output for each system is stored in $pwd\PME\LogonPasswords\

# Usage

##### Standard execution

    PsMapExec [Method] -targets All -Module LogonPasswords -ShowOutput

# Parsing

PsMapExec will parse the results from each system and present the results in a digestable and readable format. The notes field will highlight in yellow any interesting information about each result.

The table below shows the possible values for the notes field.

| Value               | Description                                                                                                  |
|---------------------|--------------------------------------------------------------------------------------------------------------|
| AdminCount=1        | The parsed account has an AdminCount value of 1. This means the account may hold privileged access.          |
| NTLM=Empty Password | The NTLM value is equal to that of an empty password.                                                        |
| Cleartext Password  | Cleartext password was parsed from the results. Shown only for user accounts, omitted for computer accounts. |
| Domain Admin        | The account is a member of a high-value group.                                                               |
| Enterprise Admin    | The account is a member of a high-value group.                                                               |
| Server Operator     | The account is a member of a high-value group.                                                               |
| Account Operator    | The account is a member of a high-value group.                                                               |

At the end of parsing all unique NTLM hashes will be shown in the console window. A Hashcat ready file will also be populated for collected NTLM hashes in 

    $pwd\PME\LogonPasswords\.AllUniqueNTLM.txt

# Optional Parameters

### 1) If specified, PsMapexec will not automatically parse output from all targets systems and identify accounts that belong to privileged groups. 

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
