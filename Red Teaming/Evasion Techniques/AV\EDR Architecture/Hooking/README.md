One of the fundamental techniques used by AVs and EDRs to monitor and control program execution is hooking. Hooking refers to intercepting or redirecting function calls or system events. There are two main levels of hooking based on where it is implemented: Userland (User Mode) and Kernelland (Kernel Mode).

Understanding the distinction between them and how they are leveraged by security solutions — and abused or bypassed by threat actors is key to mastering AV/EDR evasion.

| Feature              | Userland Hooking                            | Kernelland Hooking                          |
|----------------------|---------------------------------------------|---------------------------------------------|
| Level of Operation   | User mode                                   | Kernel mode                                 |
| Target               | API calls in DLLs                           | System calls, kernel events                 |
| Examples             | CreateProcess, VirtualAlloc, WriteFile      | NtCreateProcess, NtMapViewOfSection         |
| Bypass Methods       | Direct syscalls, unhooking                  | Rootkits, driver exploits, signed drivers   |
| Detection Coverage   | Limited to user-mode activity               | Full OS-level visibility                    |
| Deployment Complexity| Easy (no admin required)                    | Requires driver and signing                 |
| Used by              | AVs, EDRs, Injectors                        | EDRs, Rootkits, Kernel-mode malware         |

Hooking is a powerful but fragile technique for security enforcement. Userland hooks are faster and easier but more prone to evasion, while kernel hooks offer deeper insight but are harder to deploy and defend. Evasion practitioners must learn how to detect and circumvent both to effectively bypass AV/EDR protections.
