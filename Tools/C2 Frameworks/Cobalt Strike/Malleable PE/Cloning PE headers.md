# Cloning PE headers

### The stage block has several options that change the characteristics of your Beacon Reflective DLL to look like something else in memory. These are meant to create indicators that support analysis exercises and threat emulation scenarios.

## Options

#### 1) checksum = The CheckSum value in Beacon's PE header

#### 2) compile_time = The build time in Beacon's PE header

#### 3) entry_point = The EntryPoint value in Beacon's PE header

#### 4) image_size_x64 = SizeOfImage value in x64 Beacon’s PE header

#### 5) image_size_x86 = SizeOfImage value in x86 Beacon’s PE header

#### 6) name = The Exported name of the Beacon DLL

#### 7) rich_header = Meta-information inserted by the compiler

### Cobalt Strike’s Linux package includes a tool, peclone, to extract headers from a DLL and present them as a ready-to-use stage block:

 - ./peclone [/path/to/sample.dll]
