# Reconnaissance Methodology

### 1) If assigned a subnet CIDR, do a host discovery check

    fscan -h 192.168.1.0/24

    nmap -sn -T4 192.168.1.0/24 -oA subnet

### 2) Conduct a thorough portscan on any machines discovered within the subnet. If the IP addresses are too many, compile them in a list and use a scanner that can read the file to scan them all together

    sudo nmap -T4 -A -p- 192.168.1.100 192.168.1.78 -oA detailedscan

## If file (IP Addresses should be on a new line! You can also mix subnets as well.), then

    sudo nmap -T4 -A -p- -iL targets.txt -oA detailedscan

### 3) Then, depending on use case, prioritize the machine of your interest to pentest (Low Hanging Fruits)
