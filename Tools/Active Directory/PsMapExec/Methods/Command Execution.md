# Command Execution Methods

The following methods support command execution and running modules on target systems:

1) MSSQL (Need SYSADMIN on Instance)

2) SMB

3) SessionHunter (WMI)

4) WinRM

5) WMI

All currently supported command execution methods support the -Command  parameter. The command parameter can be appended to the above Authentication Types to execute given commands as a specified or current user.

    PsMapExec -Targets All -Method [Method] -Command [Command]

# Module Execution

All currently supported command execution methods support the -Module  parameter. The module parameter can be appended to the Authentication Types to execute given modules as a specified or current user.

# Authentication Types

When  -Command and -Module are omitted, PsMapExec will simply check the provided or current user credentials against the specified target systems for administrative access over the specified method.

### Current user

    PsMapExec -Targets All -Method [Method]

### With Password

    PsMapExec -Targets All -Method [Method] -Username [Username] -Password [Password]

### With Hash

    PsMapExec -Targets All -Method [Method] -Username [Username] -Hash [RC4/AES256]

### With Ticket

    PsMapExec -Targets All -Method [Method] -Ticket [doI.. OR Path to ticket file]

### Local Authentication (WMI and MSSQL only)

    PsMapExec -Targets All -Method WMI -Username Administrator -Password Password -LocalAuth

