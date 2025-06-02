# KerbDump

Dumps Kerberos tickets on the remote system.

For each system output is stored in $pwd\PME\Tickets\KerbDump\

# Usage

# Standard execution

    PsMapExec [Method] -targets All -Module KerbDump -ShowOutput

# Parsing

PsMapExec will parse the results from each system and present the results in a digestable and readable format. The notes field will highlight in yellow any interesting information about each result.

Tickets identified as a TGT will also show an easy command to execute directly after with PsMapExec to impersonate that account within the Impersonate field.

The table below shows the possible values for the notes field.

| Value         | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| TGT           | Represents a TGT ticket                                                     |
| AdminCount=1  | Identifies an account that may hold privileged permissions within the domain |
| Domain Admin  | The account is a member of one of these privileged groups                   |
| Enterprise Admin | The account is a member of one of these privileged groups               |
| Server Operator  | The account is a member of one of these privileged groups               |
| Account Operator | The account is a member of one of these privileged groups               |

# Optional Parameters

### 1) If specified, PsMapexec will not automatically parse output from all targets systems and identify accounts that belong to privileged groups.

    -NoParse

### 2) Displays each targets output to the console

    -ShowOutput

### 3) Display only successful results

    -SuccessOnly

### 4) Runs on a loop on the remote host for 5 minutes collecting tickets

    -Option kerbdump:monitor5

# Supported Methods

1) MSSQL 

2) SMB 

3) SessionHunter

4) WMI 

5) WinRM
