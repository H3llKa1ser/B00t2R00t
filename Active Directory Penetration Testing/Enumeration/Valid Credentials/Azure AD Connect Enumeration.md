# Azure AD Enumeration

## Find AAD connect server from MSOL description

    netexec smb IP -u USER -p PASSWORD -M get-desc-users | grep -i MSOL 
