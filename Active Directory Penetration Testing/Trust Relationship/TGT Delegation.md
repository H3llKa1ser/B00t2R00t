# TGT Delegation

By default, Domain Controllers are setup with Unconstrained Delegation (which is necessary in an Active Directory to correctly handle the Kerberos authentications).

If TGT delegation is enabled in the trust attributes, it is possible to coerce the remote Domain Controller authentication from the compromised Domain Controller, and retrieve its TGT in the ST. If TGT delegation is disabled, the TGT will not be added in the ST, even with the Unconstrained Delegation.

Additionally, Selective Authentication must not be enabled on the trust, and a two ways trust is needed.

## See Unconstrained Delegation!
