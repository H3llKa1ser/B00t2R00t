# Real-Time Detection

## Definition:

Real-time detection refers to the capability of the security system to detect and possibly block or quarantine malicious activity as it happens.

## Key Characteristics:

1) Immediate event processing (within milliseconds).

2) Focused on prevention and active defense.

3) Based on API hooking, behavioral signatures, heuristics, and kernel callbacks.

4) Often tightly integrated with OS mechanisms like ETW (Event Tracing for Windows), kernel filters, or userland API interception.

## Examples of Real-Time Triggers:

1) A call to CreateRemoteThread or NtWriteVirtualMemory.

2) Memory sections marked as RWX (Read-Write-Execute).

3) DLL side-loading or image tampering.

4) Untrusted execution from suspicious directories (e.g., temp folders).

## Implications for Adversaries:

1) Evasive actions must happen before detection triggers.

2) Use of delayed execution, process injection after sleep, or syscall-level abuse can help.

3) Goal: avoid triggering hooks or sensors entirely.
