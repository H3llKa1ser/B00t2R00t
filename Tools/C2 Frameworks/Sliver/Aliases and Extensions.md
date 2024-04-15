# Aliases and Extensions

### Sliver allows an operator to extend the local client console and its features by adding new commands based on third party tools. The easiest way to install an alias or extension is using the armory.

# Aliases Command Parsing

### IMPORTANT: It's important to understand that all alias commands have certain Sliver shell flags (those that appear in --help). Your Sliver shell commands are lexically parsed by the Sliver shell first, and only unnamed positional arguments are passed to the alias code. This means you may need to escape certain arguments in order for them to be correctly parsed.

### For example with Seatbelt, seatbelt -group=system will fail because the Sliver shell will attempt to interpret the -group flag as a named flag (i.e., arguments that appear in --help). To ensure this argument is parsed as a positional argument we need to tell the CLI that no more arguments are to be passed to the sliver command using --, so the correct syntax is "seatbelt -- -group=system"

### Another trick is to provide a single empty string argument, after which all arguments will be parsed as positional e.g., "seatbelt '' -group=system"

### Arguments passed to .NET assemblies and non-reflective PE extensions are limited to 256 characters. This is due to a limitation in the Donut loader Sliver is using. A workaround for .NET assemblies is to execute them in-process, using the --in-process flag, or a custom BOF extension like inline-execute-assembly. There is currently no workaround for non-reflective PE extension.

# What's the difference between an alias and an extension?

### From an end-user perspective there's not much of a difference between the two, except that extensions' arguments will show up in --help and may be required.

### An alias is essentially just a thin wrapper around the existing sideload and execute-assembly commands, and aliases cannot have dependencies.

### An extension is a shared library that is reflectively loaded into the Sliver implant process, and is passed several callbacks to return data to the implant. As such these extensions must implement the Sliver API. Extensions may also have dependencies, which are other extensions. For example, the COFF Loader is a DLL extension that loads and executes BOFs, in turn BOFs simply extensions that rely on the COFF Loader as a dependency. These types of extensions do not need to implement any Sliver-specific API, since the Sliver API is abstracted by their dependency.

# Aliases

### A Sliver alias is nothing more than a folder with the following structure:

 - an "alias.json" file

 - alias binaries on one of the following formats:

   1) .NET assemblies
  
   2) shared libraries (.so, .dll, .dylib)
  
# Alias json file structure

### It contains a single JSON object, which has the following fields:

## Field name --> Description

#### 1) name = The stylized display name of the alias

#### 2) command_name = The actual console command (primary identifier)

#### 3) entrypoint = The entrypoint (only required for DLLs / Reflective DLLs)

#### 4) help = A short help message for the command

#### 5) long_help = A longer help message describing the command and its usage

#### 6) allow_args = Specify whether the command will allow arguments or not

#### 7) files = A list of of extension files

#### 8) is_reflective = Indicates whether the extension is a reflective DLL or not

#### 9) is_assembly = Indicates whether the extension is a .NET assembly or not

### Files

#### 10) os = The operating system for which the file can be used on (i.e., GOOS syntax)

#### 11) arch = The cpu architecture (i.e., GOARCH syntax)

#### 12) path = Relative path to the file from the alias.json, parent directories are not allowed

### To load an alias in Sliver, use the alias load command:


