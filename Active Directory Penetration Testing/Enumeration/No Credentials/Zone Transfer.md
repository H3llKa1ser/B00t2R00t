# DNS Zone Transfer

## Enumerate domain name servers

    nslookup

    > set type=NS
    > DOMAINNAME.COM

## Dump all DNS records from a machine via Zone Transfer

    dig axfr DOMAIN_NAME @NAME_SERVER
