# Compromising Forests with Certificates Explained in Passive Voice

## Breaking of Forest Trusts by Compromised CAs

### The configuration for cross-forest enrollment is made relatively straightforward. The root CA certificate from the resource forest is published to the account forests by administrators, and the enterprise CA certificates from the resource forest are added to the  NTAuthCertificates and AIA containers in each account forest. To clarify, this arrangement grants the CA in the resource forest complete control over all other forests for which it manages PKI. Should this CA be compromised by attackers, certificates for all users in both the resource and account forests could be forged by them, thereby breaking the security boundary of the forest.

## Enrollment Privileges Granted to Foreign Principals

### In multi-forest environments, caution is required concerning Enterprise CAs that publish certificate templates which allow Authenticated Users or foreign principals (users/groups external to the forest to which the Enterprise CA belongs) enrollment and edit rights. Upon authentication across a trust, the Authenticated Users SID is added to the user’s token by AD. Thus, if a domain possesses an Enterprise CA with a template that allows Authenticated Users enrollment rights, a template could potentially be enrolled in by a user from a different forest. Likewise, if enrollment rights are explicitly granted to a foreign principal by a template, a cross-forest access-control relationship is thereby created, enabling a principal from one forest to enroll in a template from another forest.

### Both scenarios lead to an increase in the attack surface from one forest to another. The settings of the certificate template could be exploited by an attacker to obtain additional privileges in a foreign domain.
