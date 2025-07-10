# Real-Time vs Delayed Analysis

Detection may be immediate (real-time monitoring) or deferred (post-processing):

 - Real-Time: Userland hooks, ETW consumers, process injection alerts

 - Delayed: Memory snapshots, cloud correlation, ML analysis on backend

This means stealth payloads may execute before being caught—but defenders still gain forensic data.

## Red Team Implication: Never assume success = undetected. Post-mortem analysis could reveal everything.

