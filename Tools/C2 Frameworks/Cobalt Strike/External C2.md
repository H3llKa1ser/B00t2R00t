# External C2

### External C2 is a specification to allow third-party programs to act as a communication layer for Cobalt Strike’s Beacon payload. These third-party programs connect to Cobalt Strike to read frames destined for, and write frames with output from payloads controlled in this way. The External C2 server is what these third-party programs use to interface with your Cobalt Strike team server.

## External C2 Listener Setup

### To create an External C2 Beacon listener select Cobalt Strike -> Listeners on the main menu and press the Add button at the bottom of the Listeners tab display.

### The New Listener panel displays.

### Go to Cobalt Strike -> Listeners, press Add, and choose External C2 as your payload.

### Select External C2 as the Payload type and give the listener a Name. Make sure to give the new listener a memorable name as this name is how you will refer to this listener through Cobalt Strike’s commands and workflows.

## Parameters

### 1) Port (Bind)

 - Specify the port the External C2 server waits for connections on

### 2) Bind to localhost only

 - Check to make the External C2 server localhost- only.

## Note: External C2 listeners are not like other Cobalt Strike listeners. You cannot target these with Cobalt Strike’s post-exploitation actions. This option is just a convienence to stand up the interface itself.

## Specification

### Link: https://hstechdocs.helpsystems.com/kbfiles/cobaltstrike/attachments/externalc2spec.pdf

### Link 2: https://hstechdocs.helpsystems.com/kbfiles/cobaltstrike/attachments/extc2example.c

## Third-party Materials

### Here's a list of third-party projects and posts that reference, use, or build on External C2:

 - Custom Command and Control (C3) by F-Secure Labs. A framework for rapid
prototyping of custom C2 channels.

 - external_c2_framework by Jonathan Echavarria. A Python Framework for building
External C2 clients and servers.

 - ExternalC2 Library by Ryan Hanson .NET library with Web API, WebSockets, and a direct
socket. Includes unit tests and comments.

 - Tasking Office 365 for Cobalt Strike C2 by MWR Labs. Discussion and demo of Office
365 C2 for Cobalt Strike.

 - Shared File C2 by Outflank BV. POC to use a file/share for command and control.
