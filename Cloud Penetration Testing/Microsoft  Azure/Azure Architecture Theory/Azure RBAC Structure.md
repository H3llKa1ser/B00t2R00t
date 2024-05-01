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

# 2) Role Definition

### In Azure, a role definition is a collection of permissions that can be assigned to users, groups, service principals, or managed identities to control access to Azure resources. Role definitions define the actions that a security principal can perform on specific resources within a subscription, resource group, or resource.

### Each role definition consists of the following components:

1. **Role Name**: A descriptive name for the role definition that indicates its purpose or function, such as "Contributor", "Reader", or a custom role name.

2. **Permissions**: The set of actions or operations that the role grants permission to perform. These actions are defined using Azure Resource Manager (ARM) operations, which represent specific actions that can be performed on Azure resources, such as read, write, delete, or list.

3. **Scope**: The scope defines the level at which the role can be assigned. It specifies the Azure subscription, resource group, or individual resource to which the role applies. Role assignments are inherited by child resources within the specified scope.

4. **Assignable Scopes**: The scopes where the role definition can be assigned. This can include subscriptions, resource groups, or individual resources. Role definitions can be scoped to specific resources or made available across the entire Azure subscription.

### Azure provides several built-in role definitions with predefined sets of permissions, such as Owner, Contributor, Reader, and User Access Administrator. These built-in roles cover common scenarios and provide a starting point for managing access to Azure resources.

### Additionally, Azure allows you to create custom role definitions tailored to the specific needs of your organization. Custom roles enable you to define granular permissions by selecting the specific actions that users are allowed to perform on resources. This allows for fine-grained access control and helps to enforce the principle of least privilege.

### Overall, role definitions play a crucial role in Azure Role-Based Access Control (RBAC) by defining the permissions that govern access to Azure resources, helping organizations manage and enforce security policies effectively.

# 3) Role Assignment

### One of the interesting design choices in the Azure cloud is the way that RBAC roles are applied to this hierarchy. As noted previously, RBAC roles can be applied at the root management group, child management group, subscription, resource group, and individual resource levels.

### Any role-based access that is assigned at the root management group level propagates throughout the organization and cannot be overridden at a lower level. If an attacker manages to steal a credential that gives access at the root management group level, they could leverage this access to move laterally across different subscriptions in the organization.

### When you create a role assignment, you specify the following information:

 - The security principal (user, group, service principal, or managed identity).

 - The role definition that defines the permissions.

 - The scope at which the role assignment applies.

### For example, you might create a role assignment that grants the "Contributor" role to a specific user for a particular resource group. This would allow the user to create, update, and delete resources within that resource group.

