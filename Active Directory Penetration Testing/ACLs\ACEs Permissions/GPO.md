# ACLs/ACEs on GPO

 - MATCH (gr:Group),(gp:GPO),p=((gr)-[:GenericWrite]->(gp)) RETURN p (Bloodhound cypher query)

 - Get-DomainObjectAcl -SearchBase "CN=Policies,CN=System,DC=LOCAL,DC=COM" -ResolveGUIDs | ?{$_.ObjectAceType -eq "Group-Policy-Container"} | select ObjectDN, ActiveDirectoryRights, SecurityIdentifier | fl (SID of principals that can create new GPOs in the domain)

 - Get-DomainOU | Get-DomainObjectAcl -ResolveGUIDs | ?{$_.ObjectAceType -eq "GP-Link" -and $_.ActiveDirectoryRights -match "WriteProperty"} | select ObjectDN, SecurityIdentifier | fl (Return the principals that can write to the GP-Link attribute on OUs)

 ### Generic Write on GPO --> Abuse GPO --> Access! 
