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

### 1) DNS Hosts 

 - Press [+] to add one or more domains to beacon to. Your Cobalt Strike team server system must be authoritative for the domains you specify. Create a DNS A record and point it to your Cobalt Strike team server. Use DNS NS records to delegate several domains or sub-domains to your Cobalt Strike team server’s A record.

 - The length of the beacon host list in beacon payload is limited to 255 characters.
This includes a randomly assigned URI for each host and delimiters between
each item in the list. If the length is exceeded, hosts will be dropped from the end
of the list until it fits in the space. There will be messages in the team server log
for dropped hosts.

### 2) Host Rotation Strategy

 - This value configures the beacons behavior for choosing
which host(s) from the list to use for egress. Select one of the following:

 1) round-robin: Select to loop through the list of host names in the order they are
provided. Each host is used for one connection.

 2) random: Select to randomly select a host name from the list each time a
connection is attempted.

 3) failover-xx: Select to use a working host as long as possible. Use each host in the
list until they reach a consecutive failover count (x) or duration time period
(m,h,d), then use the next host.

 4) rotate-xx: Select to use each host for a period of time. Use each host in the list for
the specified duration (m,h,d), then use the next host.

### 3) Max Retry Strategy

 - This configures the beacons behavior for exiting after a number of
consecutive failed connection attempts to the Team Server. There are several
default options to choose from or you can create your own list with the
LISTENER_MAX_RETRY_STRATEGIES hook.

 1) none: Select to ensure beacon will not exit because of failed connection attempts.
 2) exit-xxx:  These settings use the syntax of exit-[max_attempts]-[increase_
attempts]-[duration][m,h,d]. The max_attempt value is the number of
consecutive failed attempts before beacon will exit. The increase_attempts is
the number of consecutive failed attempts before increasing the sleep time.
The duration value is the number of minutes, hours, or days to set the new
sleep time.
