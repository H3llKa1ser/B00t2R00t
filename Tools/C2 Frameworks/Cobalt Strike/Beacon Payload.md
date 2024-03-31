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

### When you generate a stageless beacon payload from the Cobalt Strike UI or a supported aggressor function, you can choose which system call method will be used at execution time.

### System Call Methods:

#### 1) None -> Use the standard Windows API function

#### 2) Direct -> Use the Nt* version of the function

#### 3) Indirect -> Jump to the apprpriate instruction within the Nt* version of the function

### There are some commands and workflows that inject or spawn a new beacon that do not allow you to set the initial system call method. In these cases, setting the ‘stage.syscall_method’ setting in the profile will allow you to control the initial method used at execution time.

### The following commands and workflows use the stage.syscall_method setting:

 - elevate
 - inject
 - jump
 - spawn
 - spawnas
 - spawnu
 - team server responding to a stageless payload request
 - team server responding to an external c2 payload request

### Use the syscall-method [method] command to modify which method will be used for subsequent commands. In addition, syscall-method without any arguments will query the current method.
