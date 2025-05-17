# Delete history file in powershell 

## Permissions: Administrator

## Command:

    Clear-History; Remove-Item "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" -Force -ErrorAction SilentlyContinue; Remove-Item $MyInvocation.MyCommand.Definition -Force

OR 

    Set-PSReadlineOption -HistorySaveStyle SaveNothing
    del (Get-PSReadlineOption).HistorySavePath

## Explanation:

### 1) Clears session history

### 2)  Deletes persistent console logs

### 3) Removes the script file itself
