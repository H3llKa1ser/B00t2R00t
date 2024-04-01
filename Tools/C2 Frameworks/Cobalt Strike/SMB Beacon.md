# SMB Beacon

### The SMB Beacon uses named pipes to communicate through a parent Beacon. This peer-topeer communication works with Beacons on the same host. It also works across the network

### Windows encapsulates named pipe communication within the SMB protocol. Hence, the name, SMB Beacon.

## SMB Listener Setup

### To create a SMB Beacon listener select Cobalt Strike -> Listeners on the main menu and press the Add button at the bottom of the Listeners tab display.

### The SMB Beacon is compatible with most actions in Cobalt Strike that spawn a payload. The exception to this are the user-driven attacks that require explicit stagers.

### Cobalt Strike post-exploitation and lateral movement actions that spawn a payload will attempt to assume control of (link) to the SMB Beacon payload for you. If you run the SMB Beacon manually, you will need to link to it from a parent Beacon.

### The New Listener panel displays.

