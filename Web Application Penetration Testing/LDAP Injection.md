# LDAP Injection

### It is used to:

 - 1) Authentication Bypass: Modifying LDAP authentication queries to log in as another user without knowing their password.

 - 2) Unauthorized Data Access: Altering LDAP search queries to retrieve sensitive information not intended for the attacker's access.

 - 3) Data Manipulation: Injecting queries that modify the LDAP directory, such as adding or modifying user attributes.

## Authentication Bypass Techniques

### Tautology-based Injection

#### Payload:

    (&(uid=*)(|(&)(userPassword=pwd)))

#### This payload functions similarly to the OR 1=1 SQL statement because it uses the logic either of the 2 statements are true, which means the entire query is true.

### Wildcard Injection

#### Injected Payload:

    username=*&password=*

### Condition always evaluates to true, bypassing the password checking mechanism

#### Targeted Injected Payload

    username=a*&password*

### This payload searches for specific targets that start with the letter a. Use more letters for more granular searching power

