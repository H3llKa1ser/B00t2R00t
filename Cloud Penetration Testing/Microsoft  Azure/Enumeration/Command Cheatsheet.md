# Enumeration Command Cheatsheet

 - Get-TenantID -domain DOMAIN (Get the tenant ID of the specific domain)

 - Get-AzADUser -SignedIn | fl (Whoami in Azure Context)

 - Get-UserObjectID -Token $tokens -upn USER.NAME@DOMAIN.LOCAL (Retrieve the ObjectID of the compromised user)

