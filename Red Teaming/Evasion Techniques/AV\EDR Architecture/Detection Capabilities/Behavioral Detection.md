# Behavioral Detection

Cited from: https://redteamleaders.coursestack.com/courses/3e9e0212-81dc-49ed-9233-ec9ca894fc6a/take/11---detection-types-signature-heuristic-behavioral-and-machine-learning

## Definition:

Behavioral detection monitors the runtime behavior of processes and correlates it with known malicious patterns.

## How It Works:

1) Runs in real-time or near real-time.

2) Tracks system calls, API chains, memory manipulation, process creation, file and registry changes.

## Examples of Suspicious Behavior:

1) CreateProcess → Inject Shellcode → CreateRemoteThread

2) Child processes spawned from MS Office or browsers.

3) Modifications to autorun registry keys or scheduled tasks.

## Advantages:

1) Detects zero-day malware based on action, not code.

2) Difficult to evade without mimicking legitimate process behavior.

## Evasion Techniques:

1) Sleep/delay tactics (e.g., Sleep(10000)).

2) Parent process spoofing (PPID spoofing).

3) Staged payload delivery with minimal in-memory footprint.

4) API call sequencing with benign lookalikes in between.
