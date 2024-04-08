# Process Injection

### The process-inject block in Malleable C2 profiles shapes injected content and controls process injection behavior for the Beacon payload. It also controls the behavior of Beacon Object Files (BOF) execution within the current beacon.

### The process-inject block accepts several options that control the process injection process in Beacon:

 - 1) allocator = The preferred method to allocate memory in the remote process. Specify VirtualAllocEx or NtMapViewOfSection. The NtMapViewOfSection option is for same-architecture injection only. VirtualAllocEx is always used for cross-arch memory allocations

 - 2) bof_allocator = The preferred method to allocate memory in the current process to execute a BOF. Specify VirtualAlloc, MapViewOfFile, or HeapAlloc.

 - 3) bof_reuse_memory = Reuse the allocated memory for subsequent BOF executions otherwise release the memory. Memory will be cleared when not in use. If the available amount of memory is not large enough it will be released and allocated with the larger size.

 - 4) min_alloc = Minimum amount of memory to request for injected or BOF content.

 - 5) startrwx = Use RWX as initial permissions for injected or BOF content. Alternative is RW. When BOF memory is not in use the permissions will be set based on this setting.

 - 6) userwx = Use RWX as final permissions for injected or BOF content. Alternative is RX.

### The transform-x86 and transform-x64 blocks pad content injected by Beacon. These blocks support two commands: prepend and append.

### The prepend command inserts a string before the injected content. The append command adds a string after the injected content. Make sure that prepended data is valid code for the injected content’s architecture (x86, x64). The c2lint program does not have a check for this.

### The execute block controls the methods Beacon will use when it needs to inject code into a process. Beacon examines each option in the execute block, determines if the option is usable for the current context, tries the method when it is usable, and moves on to the next option if code execution did not happen. 

### The execute options include:

 - 1) CreateThread = Current process only
  
 - 2) CreateRemoteThread = No cross-session (x64 -> x86 injectable)
  
 - 3) NtQueueApcThread
  
 - 4) NtQueueApcThread-s = This is the “Early Bird” injection technique. Suspended processes (e.g., post-ex jobs) only.

 - 5) RtlCreateUserThread = Risky on XP-era targets; uses RWX shellcode for x86 -> x64 injection. (Both x86 -> x64 and vice-versa injectable)
  
 - 6) SetThreadContext =  Suspended processes (e.g., post-ex jobs) only. (x64 -> x86 injectable)

### The CreateThread and CreateRemoteThread options have variants that spawn a suspended thread with the address of another function, update the suspended thread to execute the injected code, and resume that thread. Use [function]“module!function+0x##”to specify the start address to spoof. For remote processes, ntdll and kernel32 are the only recommended modules to pull from. The optional 0x##part is an offset added to the start address. These variants work x86 -> x86 and x64 -> x64 only.

### The execute options you choose must cover a variety of corner cases. These corner cases include self injection, injection into suspended temporary processes, cross-session remote process injection, x86 -> x64 injection, x64 -> x86 injection, and injection with or without passing an argument. The c2lint tool will warn you about contexts that your execute block does not cover.

# Controlling Process Injection

### Cobalt Strike 4.5 added support to allow users to define their own process injection technique instead of using the built-in techniques. This is done through the PROCESS_INJECT_ SPAWN and PROCESS_INJECT_EXPLICIT hook functions. Cobalt Strike will call one of these hook functions when executing post exploitation commands. See the section on the hook for a table of supported commands.

### The two hooks will cover most of the post exploitation commands. However, there are some exceptions which will not use these hooks and will continue to use the built-in technique.

### To implement your own injection technique, you will be required to supply a Beacon Object File (BOF) containing your executable code for x86 and/or x64 architectures and an Aggressor Script file containing the hook function. See the Process Injection Hook Examples in the Community Kit.

### Since you are implementing your own injection technique, the process-inject settings in your Malleable C2 profile will not be used unless your BOF calls the Beacon API function BeaconInjectProcess or BeaconInjectTemporaryProcess. These functions implement the default injection and most likely will not be used unless it is to implement a fallback to the default technique.

## Beacon Command -> Aggressor Script Function

#### 1) shell --> &bshell

#### 2) execute-assembly --> &bexecute-assembly

#### 3) &bdllspawn

## Process Injection Spawn

### The PROCESS_INJECT_SPAWN hook is used to define the fork&run process injection technique. The following beacon commands, aggressor script functions, and UI interfaces listed in the table below will call the hook and the user can implement their own technique or use the built-in technique.

### Note the following:

 - The elevate, runasadmin, &belevate, &brunasadmin and [beacon] -> Access -> Elevate commands will only use the PROCESS_INJECT_SPAWN hook when the specified exploit uses one of the listed aggressor script functions in the table, for example &bpowerpick.

 - For the net and &bnet command the ‘domain’ command will not use the hook.

 - The ‘(use a hash)’ note means select a credential that references a hash.

## Process Injection Explicit

### The PROCESS_INJECT_EXPLICIT hook is used to define the explicit process injection technique. The following beacon commands, aggressor script functions, and UI interfaces listed in the table below will call the hook and the user can implement their own technique or use the built-in technique.

### Note the following:

 - The [Process Browser] interface is accessed by [beacon] -> Explore -> Process List.
There is also a multi version of this interface which is accessed by selecting multiple
sessions and using the same UI menu. When in the Process Browser use the buttons to
perform additional commands on the selected process.

 - The chromedump, dcsync, hashdump, keylogger, logonpasswords, mimikatz, net,
portscan, printscreen, pth, screenshot, screenwatch, ssh, and ssh-key commands
also have a fork&run version. To use the explicit version requires the pid and architecture
arguments.

 -  For the net and &bnet command the ‘domain’ command will not use the hook
