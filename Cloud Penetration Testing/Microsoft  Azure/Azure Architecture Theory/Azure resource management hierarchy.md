# Azure resource management hierarchy

### The organization structure in Azure consists of the following levels from top to bottom:

#### 1) Azure AD Tenant

 - In order to manage Azure subscriptions and resources, administrators need an identity directory to manage users that will have access to the resources. Azure AD is the identity store that facilitates the authentication and authorization for all users in an Azure tenant's subscriptions. Every Azure subscription has a trust relationship with one Azure AD tenant to manage access to the subscription. It is common for organizations to connect their on-premises AD to Azure AD using a tool called Azure AD Connect.

## TIP: As the core of authentication and authorization, Azure AD is a prime target for information gathering, as well as different identity-based attacks.

