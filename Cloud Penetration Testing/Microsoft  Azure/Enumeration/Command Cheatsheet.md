# Enumeration Command Cheatsheet

 - Get-TenantID -domain DOMAIN (Get the tenant ID of the specific domain)

 - Get-AzADUser -SignedIn | fl (Whoami in Azure Context)

 - Get-UserObjectID -Token $tokens -upn USER.NAME@DOMAIN.LOCAL (Retrieve the ObjectID of the compromised user)

 - Get-AzResource (Returns the resources that our user may have access to)

 - Get-AzContainerApp -ResourceGroupName "RESOURCE_GROUP" -Name "CONTAINER_APP_NAME" | fl (Check information on an Azure Container App)


