Modern EDRs rely heavily on deep system monitoring techniques that allow them to track the full execution flow of a process from API calls to syscalls, memory usage, thread activity, and module loads. This visibility enables both real-time detection and forensic analysis. Understanding these mechanisms is essential for both defenders and attackers.

| Monitoring Mechanism | Used by AV/EDR         | Commonly Tracked           | Bypass Technique                          |
|----------------------|------------------------|----------------------------|--------------------------------------------|
| ETW                  | All major EDRs         | Process, Registry, Images  | Patch EtwEventWrite or unregister          |
| Syscall Tracing      | Advanced EDRs, Sandbox | Low-level API behavior     | Direct syscalls, syscall spoofing          |
| Kernel Callbacks     | Kernel-mode sensors    | Process/image/registry     | Ghosting, Obfuscation, Tampering           |

Execution flow monitoring forms the core surveillance mechanism of modern EDR solutions. ETW provides visibility, syscall tracing adds depth, and kernel callbacks give control. Bypassing or disrupting this chain of surveillance is central to stealthy malware and red team operations.

