# Limited Memory Inspection

Most AVs do not actively monitor runtime memory behavior, or do so inefficiently:

1) Memory injection, shellcode staging, and DLL hollowing often go undetected.

2) Reflective DLL injection or PE injection with memory patching can bypass static analysis.

## Limitations:

1) AVs typically scan files on disk, not memory buffers.

2) Memory regions with executable permissions (e.g., RWX) are often unmonitored.

### Evasion Tip: Use reflective loaders, avoid touching disk, and ensure payloads run only in memory.
