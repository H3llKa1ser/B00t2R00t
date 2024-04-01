# Listener and Infrastructure Management

### The first step of any engagement is to setup infrastructure. In Cobalt Strike’s case, infrastructure consists of one or more team servers, redirectors, and DNS records that point to your team servers and redirectors.Once you have a team server up and running, you will want to connect to it, and configure it to receive connections from compromised systems. Listeners are Cobalt Strike’s mechanism to do this.

### A listener is simultaneously configuration information for a payload and a directive for Cobalt Strike to stand up a server to receive connections from that payload. A listener consists of a user- defined name, the type of payload, and several payload-specific options.

## Listener Management

### To manage Cobalt Strike listeners, go to Cobalt Strike -> Listeners. This will open a tab listing all of your configured payloads and listeners.

### Press Add to create a new listener. The New Listener panel displays

### Use the Payload drop-down to select one of the available payload/listener types you wish to configure.

### To edit a listener, highlight a listener and press Edit. To remove a listener, highlight the listener and press Remove.

# Infrastructure Consolidation

### Cobalt Strike’s model for distributed operations is to stand up a separate team server for each phase of your engagement. For example, it makes sense to separate your post-exploitation and persistence infrastructure. If a post-exploitation action is discovered, you don’t want the remediation of that infrastructure to clear out the callbacks that will let you back into the network.

### Some engagement phases require multiple redirector and communication channel options. Cobalt Strike 4.0 is friendly to this.

### You can bind multiple HTTP, HTTPS, and DNS listeners to a single Cobalt Strike team server. These payloads also support port bending in their configuration. This allows you to use the common port for your channel (80, 443, or 53) in your redirector and C2 setups, but bind these listeners to different ports to avoid port conflicts on your team server system.

### To give variety to your network indicators, Cobalt Strike’s Malleable C2 profiles may contain multiple variants. A variant is a way of adding variations of the current profile into one profile file. You may specify a Profile variant when you define each HTTP or HTTPS Beacon listener.

### Further, you can define multiple TCP and SMB Beacons on one team server, each with different pipe and port configurations. Any egress Beacon, from the same team server, can control any of these TCP or SMB Beacon payloads once they’re deployed in the target environment.

