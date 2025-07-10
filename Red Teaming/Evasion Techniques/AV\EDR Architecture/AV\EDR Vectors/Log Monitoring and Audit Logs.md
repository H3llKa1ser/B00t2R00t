# Log Monitoring and Audit Logs

EDRs often leverage native Windows audit logs and event tracing logs, such as:

1) Event Viewer Logs (e.g., 4688 for process creation, 5140 for share access)

2) Sysmon logs (if deployed), for:

 - File creations (Event ID 11)

 - Registry modifications (Event ID 13)

 - Image loads (Event ID 7)

 - Network connections (Event ID 3)

These logs may be stored locally and also transmitted to centralized SIEM or XDR platforms.

### Evasion Tip: Disable or tamper with Sysmon (risky), or operate in-memory to avoid log-generating events.

