## DNS Configuration

#### 1) 

    $dnsip= "DC_IP"

#### 2) 

    $index = Get-NetAdapter -Name 'ETHERNET' | Select-Object -ExpandProperty 'ifIndex' Set-DnsClientServerAddress -InterfaceIndex $index -serverAddresses $dnsip

#### 3) 

    nslookup DOMAIN

#### 4) 

    dir \\\\DOMAIN\SYSVOL\
