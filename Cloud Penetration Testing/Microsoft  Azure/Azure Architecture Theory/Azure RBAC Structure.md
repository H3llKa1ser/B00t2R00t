# Azure RBAC Structure (Role-Based Access Control)

### RBAC is an authorization system used to control who has access to Azure resources, and the actions users can take against those resources. At a high level, you can think of it as granting security principals (users, groups, and applications) access to Azure resources, by assigning roles to the security principals.

## Components

# 1) Security Principals

### In Azure, a security principal refers to an entity that is granted access to Azure resources. This can include users, groups, service principals, or managed identities. Each security principal is assigned certain permissions, which determine what actions it can perform on Azure resources.

### Here's a breakdown of the different types of security principals in Azure:

1. **User**: A user account represents an individual who can sign in to Azure and access resources. Users can be added directly to Azure Active Directory (Azure AD) or synchronized from an on-premises Active Directory using Azure AD Connect. The accounts are commonly addressed by their User Principal Name (UPN), which is typically an email address. For example, a user named karl in the Azure AD tenant, with a domain name of azurepentesting.com, will have a UPN of karl@azurepentesting.com. External user accounts are user identities from other Azure AD tenants, or Microsoft
accounts (outlook.com, hotmail.com, and so on) that are invited as guest users to an Azure AD tenant. 

#### External user account UPN format example: david_cloudsecnews.com#EXT#@ globaladministratorazurepen.onmicrosoft.com


2. **Group**: A group is a collection of users, devices, service principals, or other groups. Groups make it easier to manage access permissions because permissions can be assigned to the group instead of individual users. Users can then be added or removed from the group to grant or revoke access.

3. **Service Principal**: A service principal is an identity used by an application or service to authenticate and access Azure resources. Service principals are typically used for non-human entities, such as applications running in Azure or external automation scripts.

4. **Managed Identity**: A managed identity is an identity created and managed by Azure for use with Azure resources. Managed identities provide an easier and more secure way for services to authenticate with Azure AD and access other Azure resources.

### Security principals are assigned roles or permissions using Azure Role-Based Access Control (RBAC). RBAC allows you to grant granular access to Azure resources based on the principle of least privilege, ensuring that each security principal has only the permissions necessary to perform its intended tasks. This helps in maintaining the security and integrity of Azure resources within your environment.

