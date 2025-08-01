# Enumerate Trust Relationship

    nltest.exe /trusted_domains

    Get-DomainTrust -Domain DOMAIN

    Get-DomainTrustMapping (Powerview)

    ldeep ldap -u USER -p 'PASSWORD' -d DOMAIN -s ldap://DC_IP trusts

    {[System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()}.GetAllTrustRelationships()


## NOTE: Don't forget to check for password reuse to move laterally
