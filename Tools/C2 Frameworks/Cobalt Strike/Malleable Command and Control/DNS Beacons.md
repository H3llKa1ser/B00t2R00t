# DNS Beacons

### You have the option to shape the DNS Beacon/Listener network traffic with Malleable C2.

### The settings are:

#### 1) dns_idle = IP address used to indicate no tasks are available to DNS Beacon. Mask for other DNS C2 values.

#### 2) dns_max_txt = Maximum length of DNS TXT responses for tasks

#### 3) dns_sleep = Force a sleep prior to each individual DNS request (in milliseconds)

#### 4) dns_stager_prepend = Prepend text to payload stage delivered to DNS TXT record stager

#### 5) dns_stager_subhost = Subdomain used by DNS TXT record stager

#### 6) dns_ttl = TTL for DNS replies

#### 7) maxdns = Maximum length of hostname when uploading data over DNS (0-255)

#### 8) beacon = DNS subhost prefix used for beaconing requests (lowercase text)

#### 9) get_A = DNS subhost prefix used for A record requests (lowercase text)

#### 10) get_AAAA = DNS subhost prefix used for AAAA record requests (lowercase text)

#### 11) get_TXT = DNS subhost prefix used for TXT record requests (lowercase text)

#### 12) put_metadata = DNS subhost prefix used for metadata requests (lowercase text)

#### 13) put_output = DNS subhost prefix used for output requests (lowercase text)

#### 14) ns_response = How to process NS Record requests. "drop" does not respond to the request (default), "idle"responds with A record for IP address from "dns_idle", "zero"responds with A record for 0.0.0.0

### You can use "ns_response" when a DNS server is responding to a target with "Server failure" errors. A public DNS Resolver may be initiating NS record requests that the DNS Server in Cobalt Strike Team Server is dropping by default.

