# Foreign Listeners

### Cobalt Strike supports the concept of foreign listeners. These are aliases for x86 payload handlers hosted in the Metasploit Framework or other instances of Cobalt Strike. To pass a Windows HTTPS Meterpreter session to a friend with msfconsole, setup a Foreign HTTPS payload and point the Host and Port values to their handler. You may use foreign listeners anywhere you would use an x86 Cobalt Strike listener.

## Foreign Listeners Setup

### To create a Foreign Beacon listener select Cobalt Strike -> Listeners on the main menu and press the Add button at the bottom of the Listeners tab display.

### The New Listener panel displays.

### Select Foreign HTTP or Foreign HTTPS as the Payload type and give the listener a Name. Make sure to give the new listener a memorable name as this name is how you will refer to this listener through Cobalt Strike’s commands and workflows.

## Parameters

### 1) HTTP(S) Host (Stager)

 - This field specifies the name of the server where your foreign
listener is located.

### 2) HTTP(S) Port (Stager)

 - This field specifies the port on the server where your foreign
listener is listening for connections.
