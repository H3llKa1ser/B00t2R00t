# Signature-Based Reliance

Traditional AVs rely heavily on signature-based detection:

1) Files are scanned for byte patterns that match known malware.

2) Signatures are stored in local databases and periodically updated.

## Limitations:

1) Any modification (polymorphism, encryption, packers) invalidates the signature.

2) New malware strains or zero-days are not detected until signatures are updated.

3) AVs cannot detect fileless malware or in-memory execution techniques.

### Evasion Tip: Use custom packers, polymorphic encoders, or generate payloads dynamically at runtime to avoid signature matching.
