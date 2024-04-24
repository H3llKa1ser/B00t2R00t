# Enumerating Kerberos Delegations

#### 1) List delegations

 - ldeep ldap -u USER -p 'PASSWORD' -d DOMAIN -s ldap://DC_IP delegations

 - findDelegation.py DOMAIN/USER:PASSWORD@IP

#### 2) Unconstrained Delegation

 - Get-NetComputer -Unconstrained

 - Get-DomainComputer -Unconstrained -Properties DnsHostName (Powerview)

 - MATCH (c:Computer {unconstraineddelegation:true}) RETURN c (Bloodhound cypher query)

 - MATCH (u:User {owned:true}), (c:Computer {unconstraineddelegation:true}), p=shortestPath((u)-[*1..]->(c)) RETURN p (Bloodhound)

#### 3) Constrained Delegation

 - Get-DomainComputer -TrustedToAuth -Properties DnsHostName, MSDS-AllowedToDelegateTo (Powerview)

 - Get-DomainUser -TrustedToAuth (Powerview)

 - MATCH (c:Computer), (t:Computer), p=((c)-[:AllowedToDelegate]->(t)) RETURN p (Bloodhound cypher query)

 - MATCH (u:User {owned:true}), (c:Computer {name "MY_TARGET.FQDN"}), p=shortestPath({u)-[*1..]->(c)) RETURN p (Bloodhound)
