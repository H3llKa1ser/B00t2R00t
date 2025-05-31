# Enumerating Kerberos Delegations

#### 1) List delegations

    ldeep ldap -u USER -p 'PASSWORD' -d DOMAIN -s ldap://DC_IP delegations

    findDelegation.py DOMAIN/USER:PASSWORD@IP

#### 2) Unconstrained Delegation

    Get-NetComputer -Unconstrained

    Get-DomainComputer -Unconstrained -Properties DnsHostName (Powerview)

    findDelegation.py -dc-ip <DC_IP> domain.local/user1:password

##### For another domain across trust

    findDelegation.py -target-domain <target_domain> domain.local/user1:password

 - MATCH (c:Computer {unconstraineddelegation:true}) RETURN c (Bloodhound cypher query)

 - MATCH (u:User {owned:true}), (c:Computer {unconstraineddelegation:true}), p=shortestPath((u)-[*1..]->(c)) RETURN p (Bloodhound)

#### 3) Constrained Delegation

    Get-DomainComputer -TrustedToAuth -Properties DnsHostName, MSDS-AllowedToDelegateTo (Powerview)

    Get-DomainUser -TrustedToAuth (Powerview)

 - MATCH (c:Computer), (t:Computer), p=((c)-[:AllowedToDelegate]->(t)) RETURN p (Bloodhound cypher query)

 - MATCH (u:User {owned:true}), (c:Computer {name "MY_TARGET.FQDN"}), p=shortestPath({u)-[*1..]->(c)) RETURN p (Bloodhound)

#### 4) Resource-Based Constrained Delegation

    Get-DomainObject -Identity "dc=DOMAIN,dc=LOCAL" -Domain DOMAIN.LOCAL (Search for the ms-ds-machineaccountquota property)

    Get-DomainController (Check if the DC is running at least Windows 2012 or later)

    Get-NetComputer TARGET_COMPUTER | Select-Object -Property name, msds-allowedtoactonbehalfofotheridentity (The target computer object must NOT have the attribute msds-allowedtoactonbehalfofotheridentity set)

    findDelegation.py -dc-ip <DC_IP> domain.local/user1:password

##### For another domain across trust

    findDelegation.py -target-domain <target_domain> domain.local/user1:password

##### Check the attribute on an account

    rbcd.py -action read -delegate-to ServiceB$ domain.local/user1:password
