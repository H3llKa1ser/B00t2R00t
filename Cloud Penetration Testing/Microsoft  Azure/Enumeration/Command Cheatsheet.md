# Enumeration Command Cheatsheet

#### 1) Get the tenant ID of the specific domain

    Get-TenantID -domain DOMAIN 

#### 2) Whoami in Azure Context

    Get-AzADUser -SignedIn | fl 

#### 3) Retrieve the ObjectID of the compromised user

    Get-UserObjectID -Token $tokens -upn USER.NAME@DOMAIN.LOCAL 

#### 4) Returns the resources that our user may have access to

    Get-AzResource 

#### 5) Check information on an Azure Container App

    Get-AzContainerApp -ResourceGroupName "RESOURCE_GROUP" -Name "CONTAINER_APP_NAME" | fl 


