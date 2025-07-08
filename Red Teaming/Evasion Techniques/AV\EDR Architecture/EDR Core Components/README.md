Endpoint Detection and Response (EDR) platforms are complex systems composed of several interdependent layers. Each layer plays a critical role in the detection, logging, analysis, and response to potential threats. Understanding these components is crucial to identifying where and how to evade detection.

![image](https://github.com/user-attachments/assets/b1ab1b09-a054-4d93-aa88-cc995f2b4bfc)

# EDR Components and their Roles

| Component     | Layer       | Role                                      | Evasion Focus Areas                         |
|---------------|-------------|-------------------------------------------|---------------------------------------------|
| Sensor        | Endpoint    | Capture API/system events                 | Syscall use, API hiding, DLL unhooking      |
| Kernel Driver | Kernel      | Intercept system calls, protect processes | Direct syscall, rootkit techniques          |
| Userland      | Application | Monitor APIs and user behavior            | NTDLL patching, delayed execution           |
| Backend       | Server-side | Analyze telemetry, alert generation       | Reduce indicators, encode traffic           |
| Cloud         | External    | Machine learning, sandboxing, threat intel| Environment detection, timing delays        |
