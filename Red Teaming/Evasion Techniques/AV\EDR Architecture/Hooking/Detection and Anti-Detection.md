# Detection and Anti-Detection

## Indicators of Hooking:

1) Prologue modification (e.g., JMP instructions).

2) Suspicious DLLs in memory (e.g., unknown EDR hooks).

3) Differences in loaded ntdll.dll between memory and disk.

## Detection Tools:

 - PE-sieve, HookFinder, HollowsHunter, Detect-It-Easy.

## Unhooking Strategies:

1) Manual Patching: Copy clean syscall instructions into memory.

2) ReMap ntdll.dll: Load a fresh copy manually.

3) Use SysWhispers/Hell's Gate: Avoid user-mode altogether.
