# SMB Beacon

### The SMB Beacon uses named pipes to communicate through a parent Beacon. This peer-topeer communication works with Beacons on the same host. It also works across the network

### Windows encapsulates named pipe communication within the SMB protocol. Hence, the name, SMB Beacon.

## SMB Listener Setup

### To create a SMB Beacon listener select Cobalt Strike -> Listeners on the main menu and press the Add button at the bottom of the Listeners tab display.

### The SMB Beacon is compatible with most actions in Cobalt Strike that spawn a payload. The exception to this are the user-driven attacks that require explicit stagers.

### Cobalt Strike post-exploitation and lateral movement actions that spawn a payload will attempt to assume control of (link) to the SMB Beacon payload for you. If you run the SMB Beacon manually, you will need to link to it from a parent Beacon.

### The New Listener panel displays.

### Select Beacon SMB as the Payload type and give the listener a Name. Make sure to give the new listener a memorable name as this name is how you will refer to this listener through Cobalt Strike’s commands and workflows.

## Parameters

### 1) Pipename (C2)

 - Set an explicit pipename or accept the default option.

### 2) Guardrails

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
Server Name: Enter a specific computer name, or a value that:
l “starts with”supported by “*”wildcard character on the right side
l “ends with”supported by “*”wildcard character on the left side
The guard is case-insensitive

 3) Domain: Enter a specific domain, or a value that:
l “starts with”supported by “*”wildcard character on the right side
l “ends with”supported by “*”wildcard character on the left side
The guard is case-insensitive

## Linking and Unlinking

### From the Beacon console, use link [host] [pipe] to link the current Beacon to an SMB Beacon that is waiting for a connection. When the current Beacon checks in, its linked peers will check in too.

### To blend in with normal traffic, linked Beacons use Windows named pipes to communicate. This traffic is encapsulated in the SMB protocol. There are a few caveats to this approach:

#### 1) Hosts with an SMB Beacon must accept connections on port 445.

#### 2) You may only link Beacons managed by the same Cobalt Strike instance.

### If you get an error 5 (access denied) after you try to link to a Beacon: steal a domain user’s token or use make_token DOMAIN\user password to populate your current token with valid credentials for the target. Try to link to the Beacon again.

### To destroy a Beacon link use unlink [ip address] [session PID] in the parent or child. The [session PID] argument is the process ID of the Beacon to unlink. This value is how you specify a specific Beacon to de-link when there are multiple children Beacons.

### When you de-link an SMB Beacon, it does not exit and go away. Instead, it goes into a state where it waits for a connection from another Beacon. You may use the link command to resume control of the SMB Beacon from another Beacon in the future.

