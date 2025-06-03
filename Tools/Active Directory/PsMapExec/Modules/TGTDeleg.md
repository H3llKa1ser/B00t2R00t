# TGTDeleg

This module builds upon the SessionExec module. Whereby, execution on a remote host will perform a TGTDeleg operation from Rubeus under each user logon on the remote system.

Output for  TGTDeleg is stored $PWD\PME\TGTDeleg\.

## NOTE: There are some limitations with this module. It is not possible to use TGTDeleg to obtain a useable TGT for a user if they are a member of the "Protected Users" group of if they have the flag "This account is sensitive and cant be delegated" enabled.

# Usage

##### Standard execution

    PsMapExec [Method] -targets All -Module TGTDeleg

# Parsing

PsMapExec will parse the results from each system and present the results in a digestible and readable format. The notes field will highlight in yellow any interesting information about each result. Additionally, the output will generate easy one liner commands to run to impersonate the user.

The table below shows the possible values for the notes field.

| Value                                         | Description                                                                 |
|-----------------------------------------------|-----------------------------------------------------------------------------|
| AdminCount=1                                  | Identifies an account that may hold privileged permissions within the domain |
| Domain Admin, Enterprise Admin, Server Operator, Account Operator | The account is a member of one of these privileged groups                   |

# Optional Parameters

### 1) If specified, PsMapexec will not parse the ticket output.

    -NoParse

### 2) Displays each targets output to the console

    -ShowOutput

### 3) Display only successful results

    -SuccessOnly
