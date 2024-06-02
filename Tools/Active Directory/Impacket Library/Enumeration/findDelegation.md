## Use this impacket module to check for constrained delegation privileges on a user

#### 1) impacket-findDelegation -dc-ip DC_IP -k -no-pass DOMAIN.COM/USERNAME (Use Kerberos authentication)

#### 2) impacket-findDelegation -dc-ip DC_IP 'DOMAIN.COM/USERNAME:PASSWORD' (Use valid credentials to check)

#### 3) impacket-findDelegation -dc-ip DC_IP 'DOMAIN.COM/USERNAME' -hashes 'LM_HASH:NTLM_HASH' (Use NTLM authentication)
