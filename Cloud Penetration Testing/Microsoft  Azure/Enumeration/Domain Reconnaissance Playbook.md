# Domain Reconnaissance Playbook

## Steps:

### 1) Manually check if a particular company is using Entra ID for authentication by browsing to the URL below:

 - https://login.microsoftonline.com/getuserrealm.srf?login=COMPANY_NAME.COM&xml=1

### In the XML output, if the NameSpaceType value shows as "Managed" then the company is using Entra ID.

### Microsoft uses GetUserRealm.srf for what's called "user realm discovery". When a username is entered on a Microsoft sign-in page, a request is sent to this endpoint to determine the type of account associated with that username.

### 2) If we verified that our target actually uses Entra ID, we can get more information about the tenant.

 - https://login.microsoftonline.com/megabigtech.com/.well-known/openid-configuration (Get information like the TenantID for example)

### The .well-known/openid-configuration endpoint is used in the context of OpenID Connect (OIDC), which is an identity layer on top of the OAuth 2.0 protocol. This endpoint is critical for clients to discover how to interact with the identity provider's OAuth 2.0 and OpenID Connect services. Due to this being necessary for the functionality of the identity flow, it is something that cannot be changed easily.

### 3) Run the next command from the AADInternals module, to answer the following questions:

 - Invoke-AADIntReconAsOutsider -DomainName DOMAIN.COM


 - 1) DNS:	Does the DNS record exist?

 - 2) MX:	Does the MX point to Office 365?

 - 3) SPF:	Does the SPF contain Exchange Online?

 - 4) Type:	Federated or Managed

 - 5) DMARC:	Is the DMARC record configured?

 - 6) DKIM:	Is the DKIM record configured?

 - 7) MTA-STS:	Is the MTA-STS recored configured?

 - 8) STS:	The FQDN of the federated IdP’s (Identity Provider) STS (Security Token Service) server

 - 9) RPS:	Relaying parties of STS (AD FS). Requires -GetRelayingParties switch.

### 4) Our next step will be to gather possible users, and the email format(s) in use by the company, so that we can use them for a phishing or password spay attack. Social Media sources like LinkedIn, the company's website, and other social media platforms are worth reviewing. Tools like BridgeKeeper can scrape employee names from LinkedIn profiles to convert them into potential usernames.

## Bridgekeeper tool: https://github.com/0xZDH/BridgeKeeper
