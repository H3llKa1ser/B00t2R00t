# User Enumeration

## Get all Users first!

## Tools: ad-ldap-enum https://github.com/CroweCybersecurity/ad-ldap-enum

## Commands:

    GetADUsers.py -all -dc-ip DC_IP DOMAIN/USERNAME

    netexec smb IP -u USER -p PASSWORD --users

    ldeep ldap -u USER -p 'PASSWORD' -d DOMAIN -s ldap://DC_IP users

    python3 ad-ldap-enum.py -d DOMAIN.LOCAL -l TARGET_IP -u USER -p PASS (Use LDAP for authentication to enumerate)

    Get-ADUser -Filter * | Ft Name, UserPrincipalName, Enabled

### List AD enabled users that DO NOT require smart card authentication (PKI environment)

    Get-ADUser -filter {Enabled -eq $TRUE -and SmartcardLogonRequired -eq $FALSE}

### List users that you can ASREPRoast

    Get-ADUser -Filter 'useraccountcontrol -band 4194304' -Properties useraccountcontrol | Format-Table name

### List users of DNS Admins group

    Get-ADGroupMember -Identity "DNSAdmins" -Recursive

### Password in Object Description (VERY IMPORTANT!)

    Get-ADUser -Filter {description -like '*'} -Properties samaccountname, description | Select-Object samaccountname, description
