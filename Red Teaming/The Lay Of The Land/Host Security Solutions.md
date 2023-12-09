### Commads:

#### 1) wmic /namespace:\\root\securitycenter2 path antivirusproduct

### Powershell

#### 1) Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct

### Windows Defender

#### 1) Get-Service WinDefend

#### 2) Get-MpComputerStatus | select RealTimeProtectionEnabled
