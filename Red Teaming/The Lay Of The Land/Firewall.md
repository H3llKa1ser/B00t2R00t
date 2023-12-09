### powershell.exe

#### Get-NetFirewallProfile | Format-Table Name, Enabled

### If we have admin privileges we can disable the firewall:

#### 1) Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False

#### 2) Get-NetFirewallProfile | Format-Table Name, Enabled

### Check Rules

#### Get-NetFirewallRule | select DisplayName, Enabled, Description

### Test Inbound Connections

#### Test-NetConnection -ComputerName 127.0.0.1 -Port PORT
