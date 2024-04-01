# TCP Beacon

### The TCP Beacon uses a TCP socket to communicate through a parent Beacon. This peer-to-peer communication works with Beacons on the same host and across the network.

## TCP Listener Setup

### To create a TCP Beacon listener select Cobalt Strike -> Listeners on the main menu and press the Add button at the bottom of the Listeners tab display.

### The New Listener panel displays.

### Select Beacon TCP as the Payload type and give the listener a Name. Make sure to give the new listener a memorable name as this name is how you will refer to this listener through Cobalt Strike’s commands and workflows

### The TCP Beacon configured in this way is a bind payload. A bind payload is one that waits for a connection from its controller (in this case, another Beacon session).

## Parameters

### 1) Port (C2)

 - This option controls the port the TCP Beacon will wait for connections on.

### 2) Bind to localhost only

 - - Check to have the TCP Beacon bind to 127.0.0.1 when it
listens for a connection. This is a good option if you use the TCP Beacon for
localhost-only actions.

### 3) Guardrails

 - Beacon Guardrails allows the user to create a way to restrict the targets
that the beacon can execute on.Once configured, these values will be the default
guardrail for the Stageless or Windows Stageless Payload Generators.

 - Press the ... button to open the Guardrails Settings:

 1) IP Address: Enter a specific IP Address or generic wildcard of the right most
segments. For example:
l 123.123.123.123
l 123.123.123.*
l 123.123.*.*
l 123.*.*.*

 2) User Name: Enter a specific name, or a value that:
l “starts with”supported by “*”wildcard character on the right side
l “ends with”supported by “*”wildcard character on the left side
The guard is case-insensitive.

 3) Server Name: Enter a specific computer name, or a value that:
l “starts with”supported by “*”wildcard character on the right side
l “ends with”supported by “*”wildcard character on the left side
The guard is case-insensitive
 
 4) Domain: Enter a specific domain, or a value that:
l “starts with”supported by “*”wildcard character on the right side
l “ends with”supported by “*”wildcard character on the left side
The guard is case-insensitive

### The TCP Beacon is compatible with most actions in Cobalt Strike that spawn a payload. The exception to this are, similar to the SMB Beacon, the user-driven attacks that require explicit stagers.

### Cobalt Strike post-exploitation and lateral movement actions that spawn a payload will attempt to assume control of (connect) to the TCP Beacon payload for you. If you run the TCP Beacon manually, you will need to connect to it from a parent Beacon.

## Connecting and Unlinking 

### From the Beacon console, use connect [ip address] [port] to connect the current session to a TCP Beacon that is waiting for a connection. When the current session checks in, its linked peers will check in too.

### To destroy a Beacon link use unlink [ip address] [session PID] in the parent or child session console. Later, you may reconnect to the TCP Beacon from the same host (or a different host).
