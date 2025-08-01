# ForeignGroupMember

### Users with foreign Domain Group Membership

    MATCH p=(n:User)-[:MemberOf]->(m:Group) WHERE n.domain="DOMAIN" AND m.domain<>n.domain RETURN p (Bloodhound cypher query)

### Groups with Foreign Domain Group Membership

    MATCH p=(n:Group {domain:"DOMAIN"})-[:MemberOf]->(m:Group) WHERE m.domain<>n.domain AND n.name<>m.name RETURN p

### Powerview

    Get-DomainForeignGroupMember -Domain TARGET

    convertfrom -sid SID

### If user is on both domains, we can try to abuse any overly privileged permissions
