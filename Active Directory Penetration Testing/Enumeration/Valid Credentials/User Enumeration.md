# User Enumeration

## Get all Users first!

## Tools: ad-ldap-enum https://github.com/CroweCybersecurity/ad-ldap-enum

## Commands:

 - GetADUsers.py -all -dc-ip DC_IP DOMAIN/USERNAME

 - netexec smb IP -u USER -p PASSWORD --users

 - ldeep ldap -u USER -p 'PASSWORD' -d DOMAIN -s ldap://DC_IP users

 - python3 ad-ldap-enum.py -d DOMAIN.LOCAL -l TARGET_IP -u USER -p PASS (Use LDAP for authentication to enumerate)
