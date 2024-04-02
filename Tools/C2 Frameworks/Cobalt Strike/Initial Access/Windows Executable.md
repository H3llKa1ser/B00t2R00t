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

### 
