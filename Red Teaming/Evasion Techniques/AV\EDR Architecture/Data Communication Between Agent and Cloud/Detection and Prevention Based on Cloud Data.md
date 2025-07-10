# Detection and Prevention Based on Cloud Data

The cloud backend is often where detection correlation happens:

1) Correlates events across endpoints (e.g., same file hash seen on multiple machines)

2) Detects coordinated attacks, lateral movement, privilege escalation

3) Triggers containment actions (e.g., kill process, block IP, isolate host)

4) Feeds analytics to SIEM/XDR platforms

This architecture allows detection even if the local agent is bypassed—as long as partial telemetry still reaches the cloud.
