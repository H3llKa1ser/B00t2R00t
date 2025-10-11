# Ldeep

Link: https://github.com/franc-pentest/ldeep.git

## Prerequisites

• You have shell access to the target system (e.g., via reverse shell, SSH, or exploit).

• The system allows basic shell commands (no heavy restrictions like AppArmor/SELinux lockdowns).

• The target environment supports standard shell u􀆟li􀆟es (grep, find, awk, etc.).


## Usage

### 1) Enumerate Computer Objects

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP computers

### 2) Enumerate AD metadata

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP conf

### 3) Enumerate Delegations

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP delegations

### 4) Enumerate Domain Policy

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP domain_policy

### 5) Enumerate FSMO

FSMO roles are critical domain-wide operations handled by specific Domain Controllers (DCs). This command identifies which DC hosts roles like the Schema Master, Domain Naming Master, RID Master, PDC Emulator, and Infrastructure Master. From an attacker’s perspective, knowing the FSMO role holders helps in targe􀆟ng the most influential DCs for privilege escalation or domain-wide attacks. Compromising the FSMO holder, especially the PDC or Schema Master, could allow deep control over Ac􀆟ve Directory func􀆟onality and replica􀆟on.


    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP fsmo

### 6) Enumerate gMSA credentials

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP gmsa

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP object gmsa -v

### 7) Enumerate GPOs

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP gpo

### 8) Enumerate Groups

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP groups

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP membersof 'domain admins'

### 9) Enumerate Machine Accounts

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP machines

### 10) Enumerate OUs

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP ou

### 11) Enumerate Certificate Services

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP pkis

### 12) Enumerate Schema

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP schema

### 13) Enumerate Certificate Templates

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP templates

### 14) Enumerate Users

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP users

### 15) Enumerate Kerberos pre-authentication (Accounts vulnerable to AS=REP Roasting)

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP users nokrbpreauth

### 16) Enumerate SPNs (Accounts vulnerable to Kerberoasting)

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP users spn

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP users spn -v

### 17) Enumerate LAPS

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP laps

### 18) Enumerate Memberships

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP memberships TARGET_USER -r

### 19) Enumerate User Attributes

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP '(samaccountname=TARGET_USER)' userPassword

### 20) Enumerate Identity

    ldeep ldap -u USER1 -p Password@1 -d domain.local -s ldap://DC_IP whoami
