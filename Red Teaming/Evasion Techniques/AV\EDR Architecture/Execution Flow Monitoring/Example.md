# Real-World Example

An attacker injects shellcode using NtWriteVirtualMemory into a remote process.

ETW logs the injection activity.

Syscalls are flagged by the EDR’s kernel sensor.

ObRegisterCallbacks detect the attempt to open a protected handle.

The EDR agent reports suspicious behavior based on correlation of these events.

## To bypass:

Attacker uses direct syscall stubs with random entropy.

Avoids known ETW-monitored patterns.

Spoofs PPID and creates a suspended process to avoid callbacks.
