# Kernel Driver

## Definition:

The driver operates in ring 0, providing deep integration with the operating system kernel to monitor low-level operations.

## Responsibilities:

1) Intercepts system calls, IRPs, and kernel callbacks.

2) Monitors process/thread creation, memory mapping, and device access.

3) Implements process protection (prevent tampering with EDR processes).

## Typical Capabilities:

1) ETW (Event Tracing for Windows) integration.

2) File system mini-filters.

3) Registry callbacks via CmRegisterCallbackEx.

## Evasion Considerations:

1) Difficult to bypass directly without exploiting vulnerabilities.

2) Can be bypassed via direct syscalls or undocumented NT functions.

3) Rootkits or signed vulnerable drivers are sometimes used for driver-level evasion.
