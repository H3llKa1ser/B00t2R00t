# Process Injection

### The process-inject block in Malleable C2 profiles shapes injected content and controls process injection behavior for the Beacon payload. It also controls the behavior of Beacon Object Files (BOF) execution within the current beacon.

### The process-inject block accepts several options that control the process injection process in Beacon:

 - 1) allocator = The preferred method to allocate memory in the remote process. Specify VirtualAllocEx or NtMapViewOfSection. The NtMapViewOfSection option is for same-architecture injection only. VirtualAllocEx is always used for cross-arch memory allocations

 - 2) bof_allocator = The preferred method to allocate memory in the current process to execute a BOF. Specify VirtualAlloc, MapViewOfFile, or HeapAlloc.

 - 3) bof_reuse_memory = Reuse the allocated memory for subsequent BOF executions otherwise release the memory. Memory will be cleared when not in use. If the available amount of memory is not large enough it will be released and allocated with the larger size.

 - 4) min_alloc = Minimum amount of memory to request for injected or BOF content.

 - 5) startrwx = Use RWX as initial permissions for injected or BOF content. Alternative is RW. When BOF memory is not in use the permissions will be set based on this setting.

 - 6) userwx = Use RWX as final permissions for injected or BOF content. Alternative is RX.

