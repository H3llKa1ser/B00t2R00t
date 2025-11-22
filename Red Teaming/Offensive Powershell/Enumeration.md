# Enumeration

### 1) System Information

    Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property *

### 2) Network Configuration

    Get-NetIPConfiguration | Select-Object -Property InterfaceAlias, IPv4Address, IPv6Address, DNServer

### 3) List running processes

    Get-Process | Select-Object -Property ProcessName, Id, CPU | Sort-Object -Property CPU -Descending

### 4) Access event logs for anomalies

    Get-EventLog -LogName Security | Where-Object {$_.EntryType -eq 'FailureAudit'}

### 5) Domain Users

    Get-ADUser -Filter * -Properties * | Select-Object -Property Name, Enabled, LastLogonDate

### 6) Get service status

    Get-Win32Service

### 7) Hidden Registry Keys or Values

    ls NtKeyUser:\SOFTWARE -Recurse | Where-Object Name -Match "`0"
