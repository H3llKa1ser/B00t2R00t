# Agent-Cloud Architecture

## Agent Responsibilities:

1) Collect telemetry data (process, file, registry, network, memory)

2) Apply local detection logic (signatures, heuristics, indicators)

3) Monitor system behavior via ETW, callbacks, and hooks

4) Enforce policy decisions (block execution, quarantine files)

5) Send data to the cloud for correlation and machine learning analysis

## Cloud Responsibilities:

1) Aggregate data from thousands/millions of agents

2) Correlate events across endpoints

3) Run behavioral models, graph analysis, and ML classification

4) Trigger alerts and actions (e.g., isolate host, raise ticket)

5) Store logs for forensics and compliance
