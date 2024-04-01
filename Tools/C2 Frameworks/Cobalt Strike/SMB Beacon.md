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

