# Cobalt Strike's Beacon Payload

### Most commonly, you will configure listeners for Cobalt Strike’s Beacon payload. Beacon is Cobalt Strike’s payload to model advanced attackers. Use Beacon to egress a network over HTTP, HTTPS, or DNS. You may also limit which hosts egress a network by controlling peer- topeer Beacons over Windows named pipes and TCP sockets.

### Beacon is flexible and supports asynchronous and interactive communication. Asynchronous communication is low and slow. Beacon will phone home, download its tasks, and go to sleep. Interactive communication happens in real-time.

### Beacon’s network indicators are malleable. Redefine Beacon’s communication with Cobalt Strike’s malleable C2 language. This allows you to cloak Beacon activity to look like other malware or blend-in as legitimate traffic.

## System Calls

### The Beacon payload has implemented the ability to use system calls instead of the standard Windows API functions. Currently Beacon supports a limited set of functions for this capability.

### The following functions support the use of system calls:

 - CloseHandle
 - CreateFileMapping
 - CreateRemoteThread
 - CreateThread
 - DuplicateHandle
 - GetThreadContext
 - MapViewOfFile
 - OpenProcess
 - OpenThread
 - ReadProcessMemory
 - ResumeThread
 - SetThreadContext
 - UnmapViewOfFile
 - VirtualAlloc
 - VirtualAllocEx
 - VirtualFree
 - VirtualProtect
 - VirtualProtectEx
 - VirtualQuery
 - WriteProcessMemory
