Understanding how endpoint security solutions monitor API calls and system calls is crucial for effective evasion. This section explores how AVs and EDRs observe, intercept, and analyze interactions between applications and the operating system, focusing on both user-mode and kernel-mode monitoring strategies.

# EDR Monitoring Methods

| Monitoring Method          | Description                                                                  | Visibility Level     | Common Usage         |
|----------------------------|------------------------------------------------------------------------------|-----------------------|-----------------------|
| API Hooking (Userland)     | Redirects calls to API functions through trampoline patches or IAT.          | User-mode             | EDR sensors, AVs      |
| Inline Hooking             | Overwrites the beginning of a function (prologue) to jump to a custom routine.| User-mode or Kernel   | AVs, Injectors        |
| Import Address Table (IAT) | Modifies the address of a function in the IAT of a PE file.                  | User-mode             | AVs, Malware          |
| ETW (Event Tracing for Windows) | Uses kernel instrumentation callbacks to track syscalls and events.       | Kernel + User         | EDRs, Sysmon          |
| Kernel Callbacks           | Uses kernel-mode callbacks for process, thread, image load, registry.        | Kernel-mode           | EDRs, Drivers         |
| System Call Hooks          | Intercepts syscalls at SSDT (System Service Dispatch Table).                 | Kernel-mode           | Rare (needs driver)   |
| User-Mode API Logging      | Logs all calls to high-level APIs (e.g., via Detours, MinHook).              | User-mode             | EDR telemetry         |

# Detection vs Obfuscation Game

Security tools and attackers are constantly engaged in a cat-and-mouse game:

| Security Technique            | Evasion Countermeasure                    |
|------------------------------|--------------------------------------------|
| API Hooking (kernel32.dll)   | Direct syscalls to ntdll.dll              |
| ETW Logging                  | ETW patching or disabling                 |
| Registry Change Monitoring   | Delayed or indirect modifications         |
| Image Load Callbacks         | Manual PE loading / injection             |

Understanding API and syscall monitoring is essential for designing stealthy payloads. Most EDRs rely on userland hooks and ETW tracing to build telemetry, but attackers can bypass these with techniques such as direct syscalls, manual mapping, and ETW tampering. Mastery of this area is foundational for effective EDR evasion.

