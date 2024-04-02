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

 - 3) COM Scriptlet:A .sct file to run a listener

 - 4) Java: Shellcode formatted as a byte array.

 - 5) Perl: Shellcode formatted as a byte array.

 - 6) PowerShell:PowerShell script to run shellcode

 - 7) PowerShell Command:PowerShell one-liner to run a Beacon stager.

 - 8) Python: Shellcode formatted as a byte array.

 - 9) Raw: blob of position independent shellcode.

 - 10) Ruby: Shellcode formatted as a byte array.

 - 11) Veil:Custom shellcode suitable for use with the Veil Evasion Framework.

 - 12) VBA: Shellcode formatted as a byte array.
