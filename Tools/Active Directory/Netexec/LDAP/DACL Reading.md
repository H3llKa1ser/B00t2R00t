# DACL Reading

### Identify misconfigurations and overly permissive access

    nxc ldap $ip -u $user -p $password --kdcHost domain.local -M daclread -o TARGET=Administrator ACTION=read
