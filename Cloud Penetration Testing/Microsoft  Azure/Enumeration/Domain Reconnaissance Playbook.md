# Domain Reconnaissance Playbook

## Steps:

### 1) Manually check if a particular company is using Entra ID for authentication by browsing to the URL below:

 - https://login.microsoftonline.com/getuserrealm.srf?login=COMPANY_NAME.COM&xml=1

### In the XML output, if the NameSpaceType value shows as "Managed" then the company is using Entra ID.

### Microsoft uses GetUserRealm.srf for what's called "user realm discovery". When a username is entered on a Microsoft sign-in page, a request is sent to this endpoint to determine the type of account associated with that username.

### 2) If we verified that our target actually uses Entra ID, we can get more information about the tenant.

 - https://login.microsoftonline.com/megabigtech.com/.well-known/openid-configuration (Get information like the TenantID for example)

### The .well-known/openid-configuration endpoint is used in the context of OpenID Connect (OIDC), which is an identity layer on top of the OAuth 2.0 protocol. This endpoint is critical for clients to discover how to interact with the identity provider's OAuth 2.0 and OpenID Connect services. Due to this being necessary for the functionality of the identity flow, it is something that cannot be changed easily.

