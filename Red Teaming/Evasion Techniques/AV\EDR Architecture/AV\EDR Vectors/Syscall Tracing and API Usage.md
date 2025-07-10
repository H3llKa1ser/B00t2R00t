# Syscall Tracing and API Usage

One of the most critical detection vectors is system call (syscall) tracing:

1) Hooks in ntdll.dll intercept calls like NtAllocateVirtualMemory, NtWriteVirtualMemory, NtCreateThreadEx

2) Userland EDR components trace call stacks, arguments, and call origins

3) Some advanced solutions monitor syscalls in kernel mode or via ETW

EDRs may track the sequence and frequency of syscalls—unusual chains may indicate exploitation or injection.

### Evasion Tip:

1) Use direct syscalls (bypassing API stubs)

2) Use indirect syscall stubs (SysWhispers, Hell’s Gate)

3) Randomize call sequences or insert benign calls to blend in
