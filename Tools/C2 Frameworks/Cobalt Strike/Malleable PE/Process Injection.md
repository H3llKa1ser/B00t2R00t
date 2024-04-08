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

