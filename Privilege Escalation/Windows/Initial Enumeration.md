## Initial Enumeration

| **Command** | **Description** |
| --------------|-------------------|
| `xfreerdp /v:<target ip> /u:htb-student` | RDP to lab target |
| `ipconfig /all`                                              | Get interface, IP address and DNS information  |
| `arp -a`                                                     | Review ARP table                               |
| `route print`                                                | Review routing table                           |
| `Get-MpComputerStatus`                                       | Check Windows Defender status                  |
| `Get-AppLockerPolicy -Effective \| select -ExpandProperty RuleCollections` | List AppLocker rules                           |
| `Get-AppLockerPolicy -Local \| Test-AppLockerPolicy -path C:\Windows\System32\cmd.exe -User Everyone` | Test AppLocker policy                          |
| `set`                                                        | Display all environment variables              |
| `systeminfo`                                                 | View detailed system configuration information |
| `wmic qfe`                                                   | Get patches and updates                        |
| `wmic product get name`                                      | Get installed programs                         |
| `tasklist /svc`                                              | Display running processes                      |
| `query user`                                                 | Get logged-in users                            |
| `echo %USERNAME%`                                            | Get current user                               |
| `whoami /priv`                                               | View current user privileges                   |
| `whoami /groups`                                             | View current user group information            |
| `net user`                                                   | Get all system users                           |
| `net localgroup`                                             | Get all system groups                          |
| `net localgroup administrators`                              | View details about a group                     |
| `net accounts`                                               | Get passsword policy                           |
| `netstat -ano`                                               | Display active network connections             |
| `pipelist.exe /accepteula`                                   | List named pipes                               |
| `gci \\.\pipe\`                                              | List named pipes with PowerShell               |
| `accesschk.exe /accepteula \\.\Pipe\lsass -v`                | Review permissions on a named pipe             |
