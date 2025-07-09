# Post-Event Detection

## Definition:

Post-event detection refers to analyzing collected telemetry and identifying suspicious or malicious activity after it has been executed.

## Key Characteristics:

1) Relies on stored logs, metadata, or behavioral correlations.

2) Focused on forensic investigation, threat hunting, and response.

3) Typically implemented in the EDR’s backend, SIEM systems, or cloud analytics.

## Examples of Post-Event Indicators:

1) Abnormal process trees (e.g., Word spawning PowerShell).

2) Suspicious registry key changes or persistence artifacts.

3) Rare or high-entropy network connections.

4) Detection of known malware hashes after the fact.

## Implications for Adversaries:

1) The goal is to minimize artifacts left behind.

2) Living-off-the-land techniques (LOLbins) and fileless execution help avoid post-mortem patterns.

3) Metadata minimization is key: don’t stand out.
