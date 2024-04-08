process-inject {
    # set how memory is allocated in a remote process for
injected content
    set allocator "VirtualAllocEx";

    # set how memory is allocated in the current process for BOF
content
    set bof_allocator "VirtualAlloc";
    set bof_reuse_memory "true";

    # shape the memory characteristics for injected and BOF
content
    set min_alloc "16384";
    set startrwx "true";
    set userwx "false";

    # transform x86 injected content
    transform-x86 {
        prepend "\x90\x90";
    }

    # transform x64 injected content
    transform-x64 {
      append "\x90\x90";  
    }

# determine how to execute the injected code
execute {
      CreateThread "ntdll.dll!RtlUserThreadStart";
      SetThreadContext;
      RtlCreateUserThread;
        }
}
