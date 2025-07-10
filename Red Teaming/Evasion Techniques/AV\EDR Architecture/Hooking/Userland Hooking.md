# Userland Hooking

## Definition:

Userland hooking intercepts calls made by applications to high-level APIs (such as CreateProcess, VirtualAlloc, ReadFile, etc.) in DLLs like kernel32.dll and user32.dll.

## Techniques:

1) Inline Hooking: Overwriting the prologue (first bytes) of a function to redirect execution to a monitoring or malicious function.

2) Import Address Table (IAT) Hooking: Changing function pointers in a module’s IAT to redirect to a different implementation.

3) Detour Libraries: Using Microsoft Detours or similar libraries to wrap or replace functions.

## Advantages (from AV/EDR perspective):

1) Simpler to deploy (no kernel driver needed).

2) Doesn’t require admin privileges.

3) Fast to update, especially in cloud-connected EDRs.

## Limitations:

1) Easily bypassed with direct syscalls.

2) Susceptible to unhooking by overwriting patched functions.

3) Can be invisible to child processes that are hollowed or spawned suspended.
