# Incomplete API Coverage

Traditional AVs primarily monitor common APIs such as:

 - CreateProcess, WriteFile, OpenProcess, etc.

But advanced techniques use less common or undocumented APIs, or even syscalls directly, bypassing these checks entirely.

#### Example: Using NtCreateThreadEx instead of CreateRemoteThread.

### Evasion Tip: Reimplement low-level APIs or use direct syscalls to evade API-based detections.
