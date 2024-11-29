# Phishing Campaign Setup from scratch

## WHAT DO I REQUIRE?

#### 1) At least 3 domains (Preferably host them on Cloudflare for its security features)

#### 2) At least 3 Linux Ubuntu VMs (DigitalOcean, Hostiger, AWS, etc)

### The Ubuntu VMs will consist of 1 Apache Server that will act as a redirector and 1 Evilginx reverse proxy that the actual attack will be conducted from, and 1 Gophish server that will use SMTP relays to send our spear-phishing mails.

## STEPS:

#### 1) Register domains that DO NOT IMPERSONATE big brand names like microsoft, google, etc (Chrome and firefox detect these domains as "deceptive", and as a result, any social engineering pretext can be ruined.)

#### 2) Spin up VMs on regions that are highly probable that they WON'T be blocked due to geolocation filters. Ideally, create VMs that are on the same country as your target if possible.

#### 3) Setup your DNS records to point on your VMs. (3 A Records, 1 wildcard CNAME)

### TIP: Use 3 A Records for evilginx to generate the TLS Certificates when you enable the phishlet.

### TIP 2: Set SSL/TLS encryption on your domains on Cloudflare to Full

### TIP 3: Mask your IP address by using Cloudflare ProxyDNS feature to avoid being detected by analysts that use DNS Lookup on sites like:

https://securitytrails.com/ OR https://dnschecker.org/ OR https://www.virustotal.com/gui/home/search

#### 4) Use an SMTP service instead of configuring your own. You can use any service you like, here is an example:

https://sendgrid.com/en-us

### TIP: Verify your domain that you will use for emails to bypass email authentication mechanisms. (SPF, DKIM, DMARC)

### TIP 2: DON'T FORGET TO DISABLE CLICK TRACKING OPTIONS to prevent "uglyfying" your sent URL and also, prevent your SMTP relay of being flagged as malicious

#### 4)  Wait for your domains to age out AT LEAST 1 MONTH to get out of "high-risk reputation".

#### 5) In the meanwhile, you may try to send benign emails from your newly registered domains to make their reputation trusted, or get them out of the "High-Risk" reputation. 

#### 6) Install and configure your apache server 

https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-20-04

https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu

#### 7) Install and configure your evilginx server

https://help.evilginx.com/docs/intro

### TIP: Use a forked version of evilginx to remove its IOC headers

#### 7) Create a redirector to hide your evilginx lure from bots and scanners

### TIP: Index.html with redirector contents are in the redirectors directory in this repo

#### 8) Obfuscate your index.html file to further prevent bots and scanners to crawl down to your evilginx lure

https://github.com/BinBashBanana/html-obfuscator

#### 9) Use a URL shortener on your Apache Redirector Server

https://bitly.com/pages/products/url-shortener

#### 10) After testing that everything works as expected, find a social engineering pretext for a successful campaign.

#### 11) GOOD LUCK!
