# Syscall Monitoring

## Definition:

Syscall monitoring involves observing direct transitions from user-mode to kernel-mode using instructions like syscall, int 0x2e, or sysenter.

## Monitored Syscalls:

1) NtOpenProcess, NtReadVirtualMemory

2) NtCreateThreadEx, NtWriteVirtualMemory

3) NtMapViewOfSection, NtUnmapViewOfSection

## Monitoring Approaches:

1) Hooking system call dispatch tables (SSDT)

2) Logging system call parameters via kernel driver

3) Mapping raw syscall numbers to meaningful functions

4) Using hypervisors for full visibility

## Bypass Strategies:

1) Custom syscall stubs (SysWhispers, Hell’s Gate)

2) Obfuscation of syscall usage

3) Indirect syscall chaining (via memory gadgets)

