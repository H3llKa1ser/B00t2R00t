# Manual Enumeration

## Various commands

    • Systeminfo OR systeminfo | findstr /B /C:"OS Name" /C:"OS Version"

    • Hostname | Whoami | wmic qfe (updates and patches etc)

    • Wmic logicaldisk (drives)

    • echo %USERNAME% || whoami then $env:username

    • Net user | net user noman

    • Net localgroup | net localgroup noman

    • netsh firewall show state (firewall)

    • Whoami /priv

    • Ipconfig | ipconfig /all |

    • netstat -ano | route print

    • Powershell | Get-LocalUser | Get-LocalGroup | Get-LocalGroupMember Administrators

    • Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname (check software with version 32 bit and below 64)

    • Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname

    • Get-Process

If RDP is enabled or we enable it then add this

    net localgroup administrators /add
Unattended Windows Installatiom (old files of user n pass then crack)

    dir /s sysprep.inf sysprep.xml unattended.xml unattend.xml *unattended.txt 2>null
