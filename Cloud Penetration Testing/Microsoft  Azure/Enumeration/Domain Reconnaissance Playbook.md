# Domain Reconnaissance Playbook

## Domain OSINT Link to gather information: https://aadinternals.com/osint/

## Steps:

### 1) Manually check if a particular company is using Entra ID for authentication by browsing to the URL below:

 - https://login.microsoftonline.com/getuserrealm.srf?login=COMPANY_NAME.COM&xml=1

### In the XML output, if the NameSpaceType value shows as "Managed" then the company is using Entra ID.

### Microsoft uses GetUserRealm.srf for what's called "user realm discovery". When a username is entered on a Microsoft sign-in page, a request is sent to this endpoint to determine the type of account associated with that username.

### 2) If we verified that our target actually uses Entra ID, we can get more information about the tenant.

 - https://login.microsoftonline.com/megabigtech.com/.well-known/openid-configuration (Get information like the TenantID for example)

### The .well-known/openid-configuration endpoint is used in the context of OpenID Connect (OIDC), which is an identity layer on top of the OAuth 2.0 protocol. This endpoint is critical for clients to discover how to interact with the identity provider's OAuth 2.0 and OpenID Connect services. Due to this being necessary for the functionality of the identity flow, it is something that cannot be changed easily.

### 3) Run the next command from the AADInternals module, to answer the following questions:

    Invoke-AADIntReconAsOutsider -DomainName DOMAIN.COM


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

### Azure services are also available at well-known domains and subdomains. We can enumerate if the target organization is using any of the services by looking for such subdomains.

## Azure Subdomain Enumeration Tool: 

https://github.com/yuyudhn/AzSubEnum
https://github.com/darkoperator/dnsrecon


### Command:

#### AzSubEnum

    python3 azsubenum.py -b TARGET --thread 10

#### Dnsrecon

    python3 dnsrecon.py -d company.com -D subdomains-top1mil.txt -t brt

### 5) After we enumerate domains and subdomains, we try to gather a list of possible usernames within the organization.  It's also important to understand email formats.

### With our list of potential user names we can manually test them by going to https://login.microsoftonline.com . If the username is valid we will be prompted to enter the password. Otherwise, we'll get the message "This username may be incorrect. Make sure you typed it correctly. Otherwise, contact your admin." However, this manual method will be time consuming and we can leverage tools to automate this process.

### One such tool is Omnispray which is a python3 tool that builds on other tools such as o365spray and provides a modular framework to expand enumeration and spraying beyond just a single target or application.

## Omnispray link: git clone https://github.com/0xZDH/Omnispray

