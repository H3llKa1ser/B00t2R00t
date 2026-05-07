# Enumeration

## User Enumeration

Tools: 

1) username-anarchy https://github.com/urbanadventurer/username-anarchy

2) Oh365UserFinder https://github.com/dievus/Oh365UserFinder

3) o365enum https://github.com/gremwell/o365enum

4) o365spray https://github.com/0xZDH/o365spray

### 1) Generate wordlist

    username-anarchy USER NAME -@ @megacorp.com > emails.txt

### 2) Identify valid email addresses

    python3 oh365userfinder.py -r emails.txt

### 3) Start a password spraying attack

    python3 o365enum.py -u emails.txt -p 'PASSWORD' -n 1 -m office.com

### 4) Start a brute force attack

    python3 o365spray.py --username USER.NAME@megacorp.com --passfile PASSWORDS.txt --domain megacorp.com --lockout 1 --spray

## Tenant Enumeration

### 1) Check DNS records

PowerShell

    $domain = "domain.local"
    $records = @()
    $records += Resolve-DnsName -Name $domain -Type A -ErrorAction SilentlyContinue
    $records += Resolve-DnsName -Name $domain -Type AAAA -ErrorAction SilentlyContinue
    $records += Resolve-DnsName -Name $domain -Type MX -ErrorAction SilentlyContinue
    $records += Resolve-DnsName -Name $domain -Type TXT -ErrorAction SilentlyContinue
    $records += Resolve-DnsName -Name $domain -Type NS -ErrorAction SilentlyContinue
    $records += Resolve-DnsName -Name $domain -Type CNAME -ErrorAction SilentlyContinue
    $records | Format-List

Dig

    dig domain.local any +noall +answer

### 2) Validate if the company uses a Cloud-only or federated domain

    [xml]$xmlContent = (iwr 'https://login.microsoftonline.com/getuserrealm.srf?login=domain.local&xml=1').Content
    $xmlContent.DocumentElement

### 3) Verify if the company uses Azure resources

PowerShell

    Invoke-WebRequest -Uri "https://ipinfo.io/IP_FROM_DNS_RECORDS" | Select-Object -ExpandProperty Content

Curl

    curl https://ipinfo.io/IP_FROM_DNS_RECORDS

### 4) Get the region

    curl --silent 'https://azservicetags.azurewebsites.net/api/iplookup?ipAddresses=IP_FROM_DNS_RECORDS' | jq

### 5) Obtain tenant ID

    curl -s https://login.microsoftonline.com/domain.local/v2.0/.well-known/openid-configuration | jq -r ".issuer" | awk -F "/" '{print $4}'
