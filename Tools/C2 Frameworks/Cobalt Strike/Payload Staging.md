# Payload Staging

### One topic that deserves mention, as background information, is payloading staging. Many attack frameworks decouple the attack from the stuff that the attack executes. This stuff that an attack executes is known as a payload. Payloads are often divided into two parts:the payload stage and the payload stager. A stager is a small program, usually hand-optimized assembly, that downloads a payload stage, injects it into memory, and passes execution to it. This process is known as staging.

### The staging process is necessary in some offense actions. Many attacks have hard limits on how much data they can load into memory and execute after successful exploitation. This greatly limits your post-exploitation options, unless you deliver your post-exploitation payload in stages.

### Cobalt Strike does use staging in its user-driven attacks. The stagers used in these places depend on the payload paired with the attack. For example, the HTTP Beacon has an HTTP stager. The DNS Beacon has a DNS TXT record stager. Not all payloads have stager options. Payloads with no stager cannot be delivered with these attack options.

### If you don’t need payload staging, you can turn it off. Set the host_stage option in your Malleable C2 profile to false. This will prevent Cobalt Strike from hosting payload stages on its web and DNS servers. There is a big OPSEC benefit to doing this. With staging on, anyone can connect to your server, request a payload, and analyze its contents to find information from your payload configuration.

### In Cobalt Strike 4.0 and later, post-exploitation and lateral movement actions eschew stagers and opt to deliver a full payload where possible. If you disable payload staging, you shouldn’t notice it once you’re ready to do post-exploitation.
