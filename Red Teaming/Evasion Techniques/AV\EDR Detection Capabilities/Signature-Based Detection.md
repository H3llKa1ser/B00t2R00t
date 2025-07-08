# Signature-based Detection

Cited from: https://redteamleaders.coursestack.com/courses/3e9e0212-81dc-49ed-9233-ec9ca894fc6a/take/11---detection-types-signature-heuristic-behavioral-and-machine-learning

## Definition

Signature-based detection relies on known patterns of malicious code—binary strings, hashes, or specific instruction sequences—to identify threats.

## How It Works:

1) AV engines maintain large databases of virus signatures.

2) Incoming files are scanned and compared against these signatures.

3) If a match is found, the file is flagged as malicious.

## Examples:

1) SHA-256 hash of a known Meterpreter payload.

2) Byte pattern for a Cobalt Strike beacon stage.

## Bypass Methods and Limitations

### Easily bypassed with:

1) Minor changes to code (polymorphism).

2) Obfuscation, encryption, or packing.

3) Encoding the payload (e.g., Base64, XOR).

Cannot detect novel or zero-day malware.

## Evasion Techniques:

1) Shellcode re-encoding or encryption.

2) Stub wrapping to generate new hashes.

3) Using packers or crypters.

