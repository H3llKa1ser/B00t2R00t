# DNS Beacon

### The DNS Beacon is a favorite Cobalt Strike feature. This payload uses DNS requests to beacon back to you. These DNS requests are lookups against domains that your Cobalt Strike team server is authoritative for. The DNS response tells Beacon to go to sleep or to connect to you to download tasks. The DNS response will also tell the Beacon how to download tasks from your team server.

### In Cobalt Strike 4.0 and later, the DNS Beacon is a DNS-only payload. There is no HTTP communication mode in this payload. This is a change from prior versions of the product.

## Data Channels

### Today, the DNS Beacon can download tasks over DNS TXT records, DNS AAAA records, or DNS A records. This payload has the flexibility to change between these data channels while its on target. Use Beacon’s mode command to change the current Beacon’s data channel.

### mode dns is the DNS A record data channel. mode dns6 is the DNS AAAA record channel. And, mode dnstxt is the DNS TXT record data channel. The default is the DNS TXT record data channel.

### Be aware that DNS Beacon does not check in until there’s a task available. Use the checkin command to request that the DNS Beacon check in next time it calls home.

## DNS Listener Setup

### To create a DNS Beacon listener select Cobalt Strike -> Listeners on the main menu and press the Add button at the bottom of the Listeners tab display.

### The New Listener panel displays.

### Select Beacon DNS as the Payload type and give the listener a Name. Make sure to give the new listener a memorable name as this name is how you will refer to this listener through Cobalt Strike’s commands and workflows.

## Parameters

#### DNS Hosts - Press [+] to add one or more domains to beacon to. Your Cobalt Strike team server system must be authoritative for the domains you specify. Create a DNS A record and point it to your Cobalt Strike team server. Use DNS NS records to delegate several domains or sub-domains to your Cobalt Strike team server’s A record.
