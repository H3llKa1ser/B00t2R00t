# Azure Resource Management Hierarchy

### The organization structure in Azure consists of the following levels from top to bottom:

# 1) Azure AD Tenant

 - In order to manage Azure subscriptions and resources, administrators need an identity directory to manage users that will have access to the resources. Azure AD is the identity store that facilitates the authentication and authorization for all users in an Azure tenant's subscriptions. Every Azure subscription has a trust relationship with one Azure AD tenant to manage access to the subscription. It is common for organizations to connect their on-premises AD to Azure AD using a tool called Azure AD Connect.

### Each Azure AD tenant has a unique domain name, typically in the form of TENANT_NAME.onmicrosoft.com, which is used for user sign-in and to access the Azure AD administration portal. Organizations can also add custom domains to Azure AD for branding purposes.

### Overall, an Azure AD tenant serves as the identity backbone for an organization's cloud-based and hybrid infrastructure, providing centralized identity and access management capabilities across various services and applications.

## TIP: As the core of authentication and authorization, Azure AD is a prime target for information gathering, as well as different identity-based attacks.

# 2) Root Management Group

 -  This is the top-level management group in the hierarchy, representing the entire organization. It's created by default when an Azure AD tenant is created. It provides a way to apply policies and manage access across all subscriptions and management groups in the tenant.

# 3) Child Management Group

 - If an organization has enabled the root management group, they could create child management groups under the root to simplify the management of their subscriptions. Child management groups allow organizations to group subscriptions together in a flexible structure, mainly to centrally manage access and governance. Child management groups can be nested and can support up to six levels of depth.

# 4) Subscription

 - To provision resources in Azure, we need an Azure subscription. An Azure subscription is the logical container where resources are provisioned.

# 5) Resource Group

 - Within subscriptions, there are resource groups. Resource groups are logical containers that can be used to group and manage Azure resources such as virtual machines (VMs), storage accounts, and databases.

# 6) Resources

 - Resources are the individual instances of Azure services that are deployed in an Azure subscription. The resource level is the bottom of the organization hierarchy.

