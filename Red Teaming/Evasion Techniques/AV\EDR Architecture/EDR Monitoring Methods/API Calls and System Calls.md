# API Calls and System Calls

### API Calls: 

High-level functions provided by system libraries (e.g., kernel32.dll, advapi32.dll, ws2_32.dll) that applications use to perform operations such as file manipulation, process creation, or network communication.

### System Calls (Syscalls): 

Low-level interfaces to the Windows kernel, invoked by user-mode functions to request kernel services (e.g., NtCreateFile, NtOpenProcess).

#### Example: CreateProcessA() in kernel32.dll ultimately invokes NtCreateUserProcess() via a system call.

# Why Monitor API and System Calls?

Security tools monitor these calls to:

1) Detect malicious behavior like process injection, privilege escalation, or unauthorized access.

2) Trace the execution flow of applications for behavioral analysis.

3) Enforce policies (e.g., block PowerShell spawning from Office macros).

4) Build forensic trails by logging arguments, return codes, and calling process metadata.
