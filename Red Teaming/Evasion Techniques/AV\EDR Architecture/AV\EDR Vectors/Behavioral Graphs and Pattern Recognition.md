# Behavioral Graphs and Pattern Recognition

Modern EDRs build behavioral graphs from telemetry and syscall traces:

1) Each process and event is a node

2) Relationships (e.g., injection, file write, DNS resolution) form edges

3) Graphs are analyzed for known attack patterns (e.g., LOLBAS abuse, beaconing behavior)

#### Example:

An attacker abuses MSBuild.exe to execute shellcode. The EDR graphs:

 - MSBuild’s parent (e.g., Outlook)

 - File operations

 - DNS request to suspicious domain

 - Memory write + thread creation

Even if the shellcode is not known (no signature), the pattern itself may trigger alerts.

### Evasion Tip: Break expected graph patterns (e.g., spread actions across multiple processes), or operate below the radar (e.g., sleep beacons, stage payloads).

