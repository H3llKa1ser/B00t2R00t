# DOMAIN INFORMATION GROPER (dig)

## Usage:

#### -axfr = Queries a complete listing of domain records. This attack is named DNS zone transfer.

#### dig DOMAIN_NAME = Queries A records

#### +short cuts down the output

#### dig DOMAIN_NAME MX/SOA/TTL = MX/SOA/TTL records

#### dig DOMAIN_NAME ANY +noall +answer = Query ALL DNS records

#### dig -x IP @DNS_IP = Reverse DNS lookup

#### dig @8.8.8.8 DOMAIN_NAME.COM ns (Searches for all DNS servers for this domain via google dns)

#### dig @8.8.8.8 DOMAIN_NAME.COM mx (Searches for all SMTP servers for this domain via google dns)

#### #### dig @8.8.8.8 DOMAIN_NAME.COM (Similar to a whois search)

#### Other tools: nslookup, whois
