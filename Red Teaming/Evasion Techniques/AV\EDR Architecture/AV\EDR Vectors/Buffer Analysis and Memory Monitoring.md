# Buffer Analysis and Memory Monitoring

Modern EDRs perform memory introspection to detect:

1) Injected shellcode or reflective DLLs in process space

2) Code execution from non-image sections (e.g., RWX memory)

3) Unusual memory permissions (e.g., PAGE_EXECUTE_READWRITE)

4) Entropy analysis for compressed or encrypted payloads

They use periodic buffer scanning of running processes and check for anomalies like PE headers in memory, APIs resolved via hashes, or large heap allocations.

### Evasion Tip: Use memory encryption (decrypt only at execution), store payloads in benign-looking buffers (e.g., image data), or perform trampoline execution via benign DLLs.

