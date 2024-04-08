# Post-ex User Defined Reflective DLL Loader

### Cobalt Strike 4.9 added support for using customer reflective loaders for the post-ex payloads. The Post-ex User Defined Reflective Loader example is part of the udrl-vs kit in the Arsenal Kit. Got to Help -> Arsenal and download the Arsenal Kit. Your licence key is required.

### A Post-ex User Defined Reflective Loader can only be applied to the following post-ex DLLs:


- browserpivot

- hashdump

- invokeassembly

- keylogger

- mimikatz

- netview

- portscan

- powershell

- screenshot

- sshagent


# Implementation

## Create/Compile your Reflective Loaders

### The Post-ex User Defined Reflective Loader example is part of the udrl-vs kit in the Arsenal Kit. Got to Help -> Arsenal and download the Arsenal Kit. Your license key is required. Please note that User Defined Reflective Loaders for Beacon payloads and post-ex payloads are very similar but have some subtle differences.

### The loader entry function is called with the WinAPI calling convention, and it takes a single LPVOID argument. Therefore, the entry function must be declared as follows:

void WINAPI ReflectiveLoader(LPVOID loaderArgument)

### Post-exploitation payloads assume that the DLL's entry point is called with the following order and arguments:


DllMain(<Loaded DLL Base Address>, DLL_PROCESS_ATTACH, <Pointer to
RDATA_SECTION strucutre>);
DllMain(<Loader Base Address>, 4, <Loader Argument from the entry
function>);

### The RDATA_SECTION point argument is as some long-running post-exploitation payloads obfuscate their .rdata section during the waiting period. It is the loader's responsibility to provide the following structure to the DLL:

typedef struct {
char* start; // The start address of the .rdata section
DWORD length; // The length (Size of Raw Data) of the .rdata section
DWORD offset; // The obfuscation start offset
} RDATA_SECTION, *PRDATA_SECTION;


### The obfuscation start offset ensures that the Import Address Table (IAT) will not be obfuscated. Typically, this value should be set to the size of the IMAGE_DIRECTORY_ENTRY_IAT Data Directory entry as follows:

rdata->offset = ntHeader->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_
ENTRY_IAT].Size;
