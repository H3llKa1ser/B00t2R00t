# Heuristic Detection

Cited from: https://redteamleaders.coursestack.com/courses/3e9e0212-81dc-49ed-9233-ec9ca894fc6a/take/11---detection-types-signature-heuristic-behavioral-and-machine-learning

## Definition:

Heuristic detection involves static and dynamic rule-based checks on code, looking for suspicious attributes or behaviors.

## How It Works:

1) Uses predefined rules or YARA-like pattern checks.

2) Looks for suspicious constructs:

 - API usage (e.g., VirtualAllocEx, WriteProcessMemory).

 - Anomalous section names or permissions (.text marked as RWX).

 - High entropy suggesting encryption or packing.

## Examples:

1) PE file with a small .text section and a large .data section.

2) Use of IsDebuggerPresent() API.

3) Non-standard file headers or altered PE metadata.

## Limitations:

1) May lead to false positives.

2) Bypassable with randomized structure, renaming sections, or using legitimate Windows APIs in controlled ways.

## Evasion Techniques:

1) Padding payloads to reduce entropy.

2) API call obfuscation or delay loading.

3) Splitting malicious logic across multiple stages.
