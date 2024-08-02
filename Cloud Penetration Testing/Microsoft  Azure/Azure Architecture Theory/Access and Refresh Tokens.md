# Access Token

### Purpose: An access token is used to grant access to a protected resource, like an API. It acts as a proof of authorization (but not authentication) provided by the authentication server after a successful authentication process.

### Lifetime: Access tokens are typically short-lived, ranging from a few minutes to hours, to minimize the risk if the token is compromised. The exact lifetime can depend on the system's security policies.

### Usage: They are sent with HTTP requests to access protected resources. Once the server validates that the token is valid, it grants access to the resource.

### Content: The JSON Web Token (JWT) contains claims about the bearer and the authorized scopes.

# Refresh Token

### Purpose: A refresh token is used to obtain a new access token when the current access token is expired or about to expire, without requiring the user to go through another login process.

### Lifetime: They are generally longer-lived than access tokens. It can last from hours to days, or even indefinitely, depending on the system's configuration and policies.

### Usage: They are exchanged with the authentication server for a new access token (and optionally, a new refresh token) when needed.

### Content: Typically an opaque string, not meant to be interpreted or used by clients other than to request new access tokens.

## For red teamers, an access token can be used only for a specific scope of a specific service, whereas a refresh token can be used to craft access token for other services to which the user may be permissioned. This can allow us to move laterally to other services, and potentially bypass any MFA enforcement configured for those services!
