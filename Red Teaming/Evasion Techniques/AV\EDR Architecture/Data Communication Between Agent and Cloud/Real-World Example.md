# Real-World Example

An attacker uses Reflective DLL Injection in a Cobalt Strike beacon. Locally, the EDR agent may not flag this immediately. However:

1) The DLL hash is seen across multiple hosts.

2) The parent process tree is inconsistent.

3) The command-and-control IP was already reported on VirusTotal.

As the agent sends logs to the cloud, the EDR backend correlates these patterns and raises an alert across all affected hosts—even if the initial execution evaded local heuristics.
