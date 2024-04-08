# Beacon Object Files

### A Beacon Object File (BOF) is a compiled C program, written to a convention that allows it to execute within a Beacon process and use internal Beacon APIs. BOFs are a way to rapidly extend the Beacon agent with new post-exploitation features.

## BOFs Advantages

### One of the key roles of a command & control platform is to provide ways to use external postexploitation functionality. Cobalt Strike already has tools to use PowerShell, .NET, and Reflective DLLs. These tools rely on an OPSEC expensive fork&run pattern that involves a process create and injection for each post-exploitation action. BOFs have a lighter footprint. They run inside of a Beacon process and are memory can be controlled using the malleable c2 profile within the process-inject block.

### BOFs are also very small. A UAC bypass privilege escalation Reflective DLL implementation may weigh in at 100KB+. The same exploit, built as a BOF, is <3KB. This can make a big difference when using bandwidth constrained channels, such as DNS.

### Finally, BOFs are easy to develop. You just need a Win32 C compiler and a command line. Both MinGW and Microsoft's C compiler can produce BOF files. You don't have to fuss with project settings that are sometimes more effort than the code itself.

## How do BOFs Work?

### To Beacon, a BOF is just a block of position-independent code that receives pointers to some Beacon internal APIs.

### To Cobalt Strike, a BOF is an object file produced by a C compiler. Cobalt Strike parses this file and acts as a linker and loader for its contents. This approach allows you to write positionindependent code, for use in Beacon, without tedious gymnastics to manage strings and dynamically call Win32 APIs.

## BOFs Disadvantages

### BOFs are single-file C programs that call Win32 APIs and limited Beacon APIs. Don't expect to link in other functionality or build large projects with this mechanism.

### Cobalt Strike does not link your BOF to a libc. This means you're limited to compiler intrinsics (e.g., __stosb on Visual Studio for memset), the exposed Beacon internal APIs, Win32 APIs, and the functions that you write. Expect that a lot of common functions (e.g., strlen, stcmp, etc.) are not available to you via a BOF.
 
### BOFs execute inside of your Beacon agent. If a BOF crashes, you or a friend you value will lose access. Write your BOFs carefully.

### Cobalt Strike expects that your BOFs are single-threaded programs that run for a short period of time. BOFs will block other Beacon tasks and functionality from executing. There is no BOF pattern for asynchronous or long-running tasks. If you want to build a long-running capability, consider a Reflective DLL that runs inside of a sacrificial process.


