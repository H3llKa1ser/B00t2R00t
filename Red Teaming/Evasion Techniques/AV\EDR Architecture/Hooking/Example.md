# Example

## AV/EDR Use Case: 

EDR agents hook key functions like NtOpenProcess to detect attempts to interact with protected processes (e.g., lsass.exe).

## Attacker Countermeasure:

Use direct syscall stubs to bypass userland hooks.

Patch userland functions back to original bytes (restore syscall stubs from a clean ntdll.dll).

Avoid using flagged APIs; use manual mapping, threadless injection, or early bird techniques.
