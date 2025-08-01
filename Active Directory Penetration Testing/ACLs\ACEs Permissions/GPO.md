# ACLs/ACEs on GPO

### 1) Bloodhound Cypher Query

    MATCH (gr:Group),(gp:GPO),p=((gr)-[:GenericWrite]->(gp)) RETURN p 

### 2) SID of principals that can create new GPOs in the domain

    Get-DomainObjectAcl -SearchBase "CN=Policies,CN=System,DC=LOCAL,DC=COM" -ResolveGUIDs | ?{$_.ObjectAceType -eq "Group-Policy-Container"} | select ObjectDN, ActiveDirectoryRights, SecurityIdentifier | fl 

### 3) Return the principals that can write to the GP-Link attribute on OUs

    Get-DomainOU | Get-DomainObjectAcl -ResolveGUIDs | ?{$_.ObjectAceType -eq "GP-Link" -and $_.ActiveDirectoryRights -match "WriteProperty"} | select ObjectDN, SecurityIdentifier | fl 

 ### Generic Write on GPO --> Abuse GPO --> Access! 
