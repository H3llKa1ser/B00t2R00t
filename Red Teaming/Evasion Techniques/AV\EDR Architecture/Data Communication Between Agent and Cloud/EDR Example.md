# EDR Example (CrowdStrike Falcon)

1) Agent maintains persistent TLS connection

2) Sends telemetry every few seconds

3) Uses exponential backoff when offline

4) May receive commands from cloud (e.g., to scan or isolate)
