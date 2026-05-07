# Enumeration

## User Enumeration

Tools: 

1) username-anarchy https://github.com/urbanadventurer/username-anarchy

2) Oh365UserFinder https://github.com/dievus/Oh365UserFinder

### 1) Generate wordlist

    username-anarchy USER NAME -@ @megacorp.com > emails.txt

### 2) Identify valid email addresses

    python3 oh365userfinder.py -r emails.txt

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
