# Userland Components

## Definition:

These components operate in user-mode and interface directly with OS APIs and applications.

## Responsibilities:

1) Hook WinAPI functions (e.g., via IAT, inline hooks, Detours).

2) Monitor common API calls (e.g., CreateRemoteThread, VirtualAllocEx).

3) Collect metadata and user activity.

## Tools Used:

1) DLL injections (into explorer.exe or browser processes).

2) Sandboxing or in-memory analysis.

## Evasion Considerations:

1) Use of unhooked copies of ntdll.dll or syscalls directly.

2) Timing attacks to delay execution beyond analysis window.

3) Process hollowing with benign parent process names.
