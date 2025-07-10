# Telemetry Collection

Telemetry refers to the continuous stream of behavioral data collected from the endpoint, including:

1) Process creation and termination (CreateProcess, NtCreateProcessEx)

2) Module loading (LoadLibrary, LdrLoadDll)

3) File access and modifications

4) Registry read/write operations

5) Network activity (outbound/inbound connections)

6) Parent-child relationships (process tree lineage)

Telemetry provides contextual awareness, allowing EDRs to detect chains of events (e.g., MS Office → PowerShell → network connection).

### Evasion Tip: Operate within expected parent-child chains, delay telemetry by suspending process, or inject into benign processes (e.g., explorer.exe, svchost.exe).
