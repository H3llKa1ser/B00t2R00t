EDRs and modern antivirus engines rely on multiple observation vectors to detect malicious behavior. These vectors extend beyond simple file scanning, encompassing dynamic monitoring of process behavior, memory activity, system calls, and telemetry aggregation. Understanding these vectors is essential for designing effective evasion techniques.

### Practical Detection Vectors Table

| Vector          | Monitored By                          | Used For                      |
|------------------|----------------------------------------|-------------------------------|
| Syscalls         | Userland Hooks, ETW, Kernel            | Process Injection, Exploits   |
| Memory Buffers   | Agent Scanner, Kernel Driver           | Shellcode, Reflective DLLs    |
| File Access      | Sysmon, ETW, File System Hook          | Droppers, Stagers             |
| Network          | Agent, ETW, NDIS Filter                | C2 Detection, DNS Tunneling   |
| Registry         | Registry Filter Driver                 | Persistence, Payload Loading  |
| Process Trees    | Kernel + Agent                         | LOLBAS, Anomalous Behavior    |
| Entropy/Signatures | Static Scanners                      | Packed Files, Obfuscation     |

EDRs do not rely on a single vector of detection, but instead combine multiple sources—telemetry, logs, memory, syscall graphs—to build a rich picture of activity. Bypassing them requires multi-layered obfuscation, deep knowledge of Windows internals, and constant adaptation to behavioral analysis engines.

