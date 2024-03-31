# Listener and Infrastructure Management

### The first step of any engagement is to setup infrastructure. In Cobalt Strike’s case, infrastructure consists of one or more team servers, redirectors, and DNS records that point to your team servers and redirectors.Once you have a team server up and running, you will want to connect to it, and configure it to receive connections from compromised systems. Listeners are Cobalt Strike’s mechanism to do this.

### A listener is simultaneously configuration information for a payload and a directive for Cobalt Strike to stand up a server to receive connections from that payload. A listener consists of a user- defined name, the type of payload, and several payload-specific options.

## Listener Management

