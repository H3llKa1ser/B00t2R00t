# Delete history file in powershell 

## Command:

 - Clear-History; Remove-Item "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" -Force -ErrorAction SilentlyContinue; Remove-Item $MyInvocation.MyCommand.Definition -Force

## Explanation:

### 1) Clears session history

### 2)  Deletes persistent console logs

### 3) Removes the script file itself
