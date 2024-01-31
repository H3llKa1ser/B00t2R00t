## LDAP ENUMERATION WITH WINDAPSEARCH

#### 1) windapsearch -d DC.DOMAIN.LOCAL --dc-ip DC_IP -U (Anonymous LDAP bind)

#### 2) windapsearch -d DC.DOMAIN.LOCAL --dc-ip DC_IP -U --full | grep password (Dumps all attributes from LDAP and checks for possible passwords stored in descriptions or other fields)

#### 3) windapsearch -d DC.DOMAIN.LOCAL -dc-ip DC_IP -U > users (Dumps results in a users file to be used later for password spray)
