 # PE and Memory Indicators

 ### The stage block in Malleable C2 profiles controls how Beacon is loaded into memory and edit the content of the Beacon DLL.

stage {
set userwx "false";
set compile_time "14 Jul 2009 8:14:00";
set image_size_x86 "512000";
set image_size_x64 "512000";
set obfuscate "true";
transform-x86 {
prepend "\x90\x90";
strrep "ReflectiveLoader" "DoLegitStuff";
}
transform-x64 {
# transform the x64 rDLL stage
}
stringw "I am not Beacon";
}

### The stage block accepts commands that add strings to the .rdata section of the Beacon DLL. The string command adds a zero-terminated string. The stringw command adds a wide (UTF16LE encoded) string. The data command adds your string as-is

### The transform-x86 and transform-x64 blocks pad and transform Beacon’s Reflective DLL stage. These blocks support three commands: prepend, append, and strrep.

### The prepend command inserts a string before Beacon’s Reflective DLL. The append command adds a string after the Beacon Reflective DLL. Make sure that prepended data is valid code for the stage’s architecture (x86, x64). The c2lint program does not have a check for this. The strrep command replaces a string within Beacon’s Reflective DLL.

### The stage block accepts several options that control the Beacon DLL content and provide hints to change the behavior of Beacon’s Reflective Loader:

#### 1) allocator = Set how Beacon's Reflective Loader allocates memory for the agent.Options are: HeapAlloc, MapViewOfFile, and VirtualAlloc.

#### 2) cleanup = Ask Beacon to attempt to free memory associated with the Reflective DLL package that initialized it.

#### 3) data_storage_size = Set how many entries can be stored in Beacon Data Store.

#### 4) magic_mz_x86 = Override the first bytes (MZ header included) of Beacon's Reflective DLL. Valid x86 instructions are required. Follow instructions that change CPU state with instructions that undo the change.

#### 5) magix_mx_x64 = Same as magic_mz_x86; affects x64 DLL

#### 6) magic_pe = Override the PE character marker used by Beacon's Reflective Loader with another value.

#### 7) module_x86 = Ask the x86 ReflectiveLoader to load the specified library and overwrite its space instead of allocating memory with VirtualAlloc.

#### 8) module_x64 = Same as module_x86; affects x64 loader

#### 9) obfuscate = Obfuscate the Reflective DLL’s import table, overwrite unused header content, and ask ReflectiveLoader to copy Beacon to new memory without its DLL headers.

#### 10) sleep_mask = Obfuscate Beacon and it's heap, in-memory, prior to sleeping.

#### 11) smartinject = Use embedded function pointer hints to bootstrap Beacon agent without walking kernel32 EAT

#### 12) stomppe = Ask ReflectiveLoader to stomp MZ, PE, and e_lfanew values after it loads Beacon payload

#### 13) syscall_method = Set the system call method to use on initial beacon execution.Options are None, Direct, Indirect.

#### 14) userwx = Ask ReflectiveLoader to use or avoid RWX permissions for Beacon DLL in memory

### The module_x86 and module_x64 setting now supports the ability to specify the starting ordinal value to search for an exported function. The optional 0x##part is the starting ordinal value specified as an integer. If a library is set and Beacon does not overwrite itself into the memory space then it likely the library does not have an exported function with an ordinal value of 1 through 15. To resolve this determine a valid ordinal value and specify this value using the optional syntax, for example: set module_x64 "libtemp.dll+0x90"

