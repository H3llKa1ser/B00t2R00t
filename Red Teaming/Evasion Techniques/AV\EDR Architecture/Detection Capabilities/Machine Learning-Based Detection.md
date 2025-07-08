# Machine Learning (ML) based detection

Cited from: https://redteamleaders.coursestack.com/courses/3e9e0212-81dc-49ed-9233-ec9ca894fc6a/take/11---detection-types-signature-heuristic-behavioral-and-machine-learning

## Definition:

ML detection involves training models on large datasets of benign and malicious behavior to identify anomalies or malware-like patterns.

## How It Works:

1) Uses supervised, unsupervised, or deep learning models.

2) Inputs may include:

 - API call sequence patterns.

 - Entropy values.

 - File metadata and PE header features.

 - Memory structure snapshots.

## Examples:

1) Model detects abnormal syscall patterns in a newly compiled EXE.

2) Flags an executable with a high entropy .text section and suspicious imports.

## Challenges:

1) Black-box nature makes them difficult to understand or test against.

2) High computational cost and susceptibility to adversarial ML.

## Evasion Techniques:

1) Adversarial input crafting: inserting benign noise (junk API calls, fake strings).

2) Using known good behavior (e.g., copying behavior of explorer.exe).

3) Mimicking benign software entropy and structure.

