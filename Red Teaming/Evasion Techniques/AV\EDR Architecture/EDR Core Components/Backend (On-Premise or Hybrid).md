# Backend (On-Premise or Hybrid)

## Definition:

The backend is the infrastructure that receives and processes telemetry from all endpoints in the environment.

## Responsibilities:

1) Aggregates logs and events from endpoints.

2) Applies correlation rules and threat detection logic.

3) Provides alerts and forensic analysis capabilities.

## Common Technologies:

1) SIEM (e.g., Splunk, ELK).

2) XDR platforms.

3) Graph-based correlation engines.

## Evasion Considerations:

1) Blend behavior across multiple hosts to avoid pattern matching.

2) Avoid generating high-fidelity indicators (e.g., known C2 domains).

3) Encrypt or encode communications to hide payload intent.
