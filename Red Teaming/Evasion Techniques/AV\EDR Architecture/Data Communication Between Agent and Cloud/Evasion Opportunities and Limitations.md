# Evasion Opportunities and Limitations

## Potential Evasion Techniques:

Blocking outbound traffic to cloud IPs/domains

Detecting and killing EDR agent processes or services

DNS poisoning or TLS interception (difficult if cert-pinned)

Faking data with custom agent mimicry (advanced)

Overloading or flooding telemetry channels to hide malicious activity

Operating fully in memory to avoid filesystem and registry I/O

## Limitations of Evasion:

Some EDRs work in kernel mode, harder to disable without a driver

Agents often have self-defense mechanisms

Cloud correlation can detect “low-noise” threats by pattern

Some agents enforce zero-trust policies locally (block before sending)

