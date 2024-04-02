# Windows Executable

### This package generates a Windows executable artifact that delivers a payload stager.

### Navigate to Payloads -> Windows Stager Payload.

### This package provides the following output options:

## Parameters

### 1) Listener

 - Press the ... button to select a Cobalt Strike listener you would like to output
a payload for.

### 2) Output

 - Use the drop-down to select one of the following output types.

   - 1) Windows EXE: A Windows executable

   - 2) Windows Service EXE: A Windows executable that responds to Service Control
Manager commands. You may use this executable to create a Windows
service with sc or as a custom executable with the Metasploit Framework’s
PsExec modules.

   - 3) Windows DLL: A Windows DLL that exports a StartW function that is compatible
with rundll32.exe. Use rundll32.exe to load your DLL from the command line. (rundll32 MALICIOUS.dll,StartW)

### 3) x64

  - Check the box to generate x64 artifacts that pair with an x64 stager. By default,
this dialog exports x64 payload stagers.

### 4) sign

 - - Check the box to sign an EXE or DLL artifact with a code-signing certificate. You
must specify a certificate in a Malleable C2 profile.

### Press Generate to create a payload stager artifact.

### Cobalt Strike uses its Artifact Kit to generate this output.

# Windows Executable (Stageless)

### This package exports Beacon, without a stager, as an executable, service executable, 32-bit DLL, or 64-bit DLL. A payload artifact that does not use a stager is called a stageless artifact. This package also has a PowerShell option to export Beacon as a PowerShell script and a raw option to export Beacon as a blob of position independent code.

### Navigate to Payloads -> Windows Stageless Payload.

### This package provides the following output options:

## Parameters

### 1) Listener

 - Press the ... button to select a Cobalt Strike listener you would like to output
a payload for.

### 2) Guardrails

 - - If your listener has been configured with gauardrails, the value is displayed
as the default. Use the ... button to override the settings for the beacon.

### 3) Output

 -  Use the drop-down to select one of the following output types

 - 1) PowerShell: A PowerShell script that injects a stageless Beacon into memory.
   
 - 2) Raw: A blob of position independent code that contains Beacon.
   
 - 3) Windows EXE: A Windows executable.
   
 - 4) Windows Service EXE: A Windows executable that responds to Service Control
   Manager commands. You may use this executable to create a Windows
   service with sc or as a custom executable with the Metasploit Framework's
   PsExec modules.
   
  - 5) Windows DLL: A Windows DLL that exports a StartW function that is compatible
   with rundll32.exe. Use rundll32.exe to load your DLL from the command line. (rundll32 MALICIOUS.dll,StartW)


### 4) Exit Function

 - This function determines the method/behavior that Beacon uses when
the exit command is executed.

#### 1) Process: Terminates the whole process

#### 2) Thread: Terminates only the current thread

### 5) System Call

 - Select one of the following system call methods to use at execution time
when generating a stageless beacon payload from the Cobalt Strike UI or a
supported aggressor function:

 - 1) None: Use the standard Windows API function
 - 2) Direct: Use the Nt* version of the function
 - 3) Indirect: Jump to the appropriate instruction within the Nt* version of the function
  
### 6) HTTP Library

 - Select the Microsoft library (WinINet or WinHTTP) for the generated
payload.

### 7) x64

- Check the box to generate an x64 artifact that contains an x64 payload. By
default, this dialog exports x64 payloads.

### 8) sign

 - Check the box to sign an EXE or DLL artifact with a code-signing certificate. You
must specify a certificate in a Malleable C2 profile.

### Press Generate to create a stageless artifact.

### Cobalt Strike uses its Artifact Kit to generate this output.

# Windows Executable (Stageless) Variants

### This option generates all of the stageless payloads (in x86 and x64) for all of the configured listeners.

### Navigate to Payloads -> Windows Stageless Generate All Payloads.

## Parameters

### 1) Folder

 - Press the folder button to select a location to save the listener(s).

### 2) System Call

 - Select one of the following system call methods to use at execution time
when generating a stageless beacon payload from the Cobalt Strike UI or a
supported aggressor function:

 - 1) None: Use the standard Windows API function
 - 2) Direct: Use the Nt* version of the function
 - 3) Indirect: Jump to the appropriate instruction within the Nt* version of the function

### 3) HTTP Library

 - Select the Microsoft library (WinINet or WinHTTP) for the generated
payload.

### 4) sign

 - Check the box to sign an EXE or DLL artifact with a code-signing certificate. You
must specify a certificate in a Malleable C2 profile.

### Press Generate to create a stageless artifact.
