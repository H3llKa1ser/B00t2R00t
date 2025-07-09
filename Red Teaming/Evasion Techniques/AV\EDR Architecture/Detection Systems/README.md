One of the foundational concepts in understanding EDR (Endpoint Detection and Response) effectiveness is the distinction between real-time detection and post-event detection. This classification defines when and how the threat is identified—during execution (real-time) or after the malicious activity has already occurred (post-event). For evasion purposes, knowing the difference allows attackers and defenders to time or disguise actions accordingly.

# Detection Comparison Table

| Timing                     | During execution                         | After execution                             |
|----------------------------|------------------------------------------|---------------------------------------------|
| Primary Goal               | Prevention / Blocking                    | Detection / Investigation                   |
| Methods Used              | API Hooks, ETW, Callbacks, Kernel Filters| Log Analysis, Heuristics, Anomaly Detection |
| Common Technologies        | Sensor Drivers, ETW Consumers, API Detours| SIEM, Cloud Correlators, Threat Intel DB   |
| Reaction Time              | Milliseconds                             | Minutes to Hours (or Manual)                |
| Examples                   | Blocking malicious DLL injection         | Detecting encoded PowerShell post-execution |
| Adversary Evasion Tactics | Syscall Obfuscation, Sleep Skipping, Staging | Cleanup, LOLbins, Low-profile behaviors  |

Understanding the timing and scope of detection is essential to designing effective evasion techniques. Real-time detection focuses on stopping threats before they complete, while post-event detection relies on analyzing traces left behind. Mastering the distinction empowers red teamers to tailor payload behavior for stealth, and helps blue teamers understand detection gaps.

