# Execution Flow Monitoring

Execution flow monitoring refers to tracking the sequence and behavior of function calls and events during a program's execution. This includes:

1) High-level API usage (CreateProcess, WriteFile, etc.)

2) Low-level system calls (NtCreateProcess, NtWriteVirtualMemory, etc.)

3) Memory and thread operations

4) Module loading, image mapping

5) Registry and file access

6) Object handles and callbacks

This data is captured in different ways, including:

1) ETW (Event Tracing for Windows)

2) Syscalls (direct and indirect tracing)

3) Kernel callbacks and notifications
