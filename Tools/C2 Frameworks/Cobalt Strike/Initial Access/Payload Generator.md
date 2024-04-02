# Payload Generator

### Cobalt Strike's Payload Generator outputs source code and artifacts to stage a Cobalt Strike listener onto a host. Think of this as the Cobalt Strike version of msfvenom.

### Navigate to Payloads -> Stager Payload Generator.

## Parameters

### 1) Listener

 - Press the ... button to select a Cobalt Strike listener you would like to output
a payload for.

### 2) Output


 - Use the drop-down to select one of the following output types (most options
give you shellcode formatted as a byte array for that language):


 - 1) C: Shellcode formatted as a byte array.

 - 2) C#: Shellcode formatted as a byte array.

 - 3) COM Scriptlet: A .sct file to run a listener

 - 4) Java: Shellcode formatted as a byte array.

 - 5) Perl: Shellcode formatted as a byte array.

 - 6) PowerShell: PowerShell script to run shellcode

 - 7) PowerShell Command: PowerShell one-liner to run a Beacon stager.

 - 8) Python: Shellcode formatted as a byte array.

 - 9) Raw: blob of position independent shellcode.

 - 10) Ruby: Shellcode formatted as a byte array.

 - 11) Veil: Custom shellcode suitable for use with the Veil Evasion Framework.

 - 12) VBA: Shellcode formatted as a byte array.

### 3) x64

 - Check the box to generate an x64 stager for the selected listener.

### Press Generate to create a Payload for the selected output type.

# Payload Generator (Stageless)

### Cobalt Strike's Payload Generator outputs source code and artifacts, without a stager, to a Cobalt Strike listener onto a host.

### Navigate to Payloads -> Stageless Payload Generator.

## Parameters

### 1) Listener

 - Press the ... button to select a Cobalt Strike listener you would like to output
a payload for.

### 2) Guardrails

 - - If your listener has been configured with guardrails, the value is displayed
as the default. Use the ... button to override the settings for the beacon.

### 3) Output

 - Use the drop-down to select one of the following output types (most options
give you shellcode formatted as a byte array for that language):

 - 1) C: Shellcode formatted as a byte array.

 - 2) C#: Shellcode formatted as a byte array.

 - 3) Java: Shellcode formatted as a byte array.

 - 4) Perl: Shellcode formatted as a byte array.

 - 5) Python: Shellcode formatted as a byte array.

 - 6) Raw: blob of position independent shellcode.

 - 7) Ruby: Shellcode formatted as a byte array.

 - 8) VBA: Shellcode formatted as a byte array.

### 4) Exit Function

 - This function determines the method/behavior that Beacon uses when
the exit command is executed.

#### 1) Process: Terminates the whole process

#### 2) Thread: Terminates only the current thread

### 5) System Call

 - Select one of the following system call methods to use at execution time
when generating a stageless beacon payload from the Cobalt Strike UI or a
supported aggressor function:

#### 1) None: Use the standard Windows API function.

#### 2) Direct: Use the Nt* version of the function.

#### 3) Indirect: Jump to the appropriate instruction within the Nt* version of the function.

### 6) HTTP Library

 - Select the Microsoft library (WinINet or WinHTTP) for the generated
payload.

### 7) x64

 - Check the box to generate an x64 stager for the selected listener.
