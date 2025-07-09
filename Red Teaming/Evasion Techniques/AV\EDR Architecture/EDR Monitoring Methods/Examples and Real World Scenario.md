# Examples and Real World Scenarios

### 1) Process Injection Monitoring:

 - VirtualAllocEx, WriteProcessMemory, CreateRemoteThread are flagged.

 - EDR logs the full injection chain and arguments (target PID, buffer, size).

### 2) Fileless Execution Monitoring:

 - EDRs detect PowerShell invoking encoded commands via -enc flag.

 - API call patterns + command-line arguments = detection logic.

### 3) Network Activity:

 - Calls to WSAConnect, connect, or HttpSendRequest are monitored.

 - EDR may intercept arguments to see destination IP/domain.

## Real-World Scenario

#### Scenario: A malware performs process hollowing by:

1) Creating a suspended process.

2) Unmapping the target image.

3) Writing shellcode.

4) Resuming the thread.

#### Monitored API Calls:

CreateProcess, NtUnmapViewOfSection, WriteProcessMemory, ResumeThread.

#### EDR Response:

 - Flags unusual call sequence + memory permissions.

 - Real-time alert or post-event correlation triggered.

#### Evasion Tactic:

Use syscall-level injection, avoid known API calls, use delay and obfuscation.
