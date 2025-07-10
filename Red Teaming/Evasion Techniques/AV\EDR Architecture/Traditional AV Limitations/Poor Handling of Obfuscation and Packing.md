# Poor Handling of Obfuscation and Packing

Modern malware uses:

1) XOR, RC4, AES encryption of payloads

2) String and import obfuscation

3) Runtime unpacking (e.g., UPX or custom stubs)

AVs often fail to unpack or emulate code execution.

### Evasion Tip: Use custom encryption, dynamically resolve imports, and hide shellcode in alternative encodings (IPv6, UUID, MAC format).
