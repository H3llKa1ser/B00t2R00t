# User Defined Reflective DLL Loader

### Cobalt Strike 4.4 added support for using customized reflective loaders for beacon payloads. The User Defined Reflective Loader (UDRL) Kit is the source code for the UDRL example. Go to Help -> Arsenal and download the UDRL Kit. Your licence key is required.

## NOTE: The reflective loader's executable code is the extracted .text section from a user provided compiled object file. The extracted executable code must be less than 100KB.

# Implementation

### The following Aggressor script hooks (functions) are provided to allow implementation of User Defined Reflective Loaders:

#### 1) BEACON_RDLL_GENERATE = Hook used to implement basic Reflective Loader replacement

#### 2) BEACON_RDLL_SIZE = This hook is called when preparing beacons and allows the user to configure more than 5 KB space for their reflective loader (up to 100KB). This hook can also be used to remove the entire space for the reflective loader.

#### 3) BEACON_RDLL_GENERATE_LOCAL = Hook used to implement advanced Reflective Loader replacement. Additional arguments provided include Beacon ID, GetModuleHandleA address, and GetProcAddress address.

### The following Aggressor script functions are provided to extract the Reflective Loader executable code (.text section) from a compiled object file and insert the executable code into the beacon payload:

#### 1) extract_reflective_loader = Extracts the Reflective Loader executable code from a byte array containing a compiled object file.

#### 2) setup_reflective_loader = Inserts the Reflective Loader executable code into the beacon payload.

### The following Aggressor script functions are provided to modify the beacon payload using information from the Malleable C2 profile:

#### 1) setup_strings = Apply the strings defined in the Malleable C2 profile to the beacon payload.

#### 2) setup_transformations = Apply the transformation rules defined in the Malleable C2 profile to the beacon payload.

### The following Aggressor script function is provided to obtain information about the beacon payload to assist with custom modifications to the payload:

#### 1) pedump = Loads a map of information about the beacon payload. This map information is similar to the output of the "peclone" command with the "dump" argument.

### The following Aggressor script functions are provided to perform custom modifications to the beacon payload:

## NOTE: Depending on the custom modifications made (obfuscation, mask, etc...), the reflective loader may have to reverse those modifications when loading.

#### 1) pe_insert_rich_header = Insert rich header data into Beacon DLL Content. If there is existing rich header information, it will be replaced.

#### 2) pe_mask = Mask data in the Beacon DLL Content based on position and length.

#### 3) pe_mask_section = Mask data in the Beacon DLL Content based on position and length.

#### 4) pe_mask_string = Mask a string in the Beacon DLL Content based on position.

#### 5) pe_patch_code = Patch code in the Beacon DLL Content based on find/replace in '.text' section'.

#### 6) pe_remove_rich_header = Remove the rich header from Beacon DLL Content.

#### 7) pe_set_compile_time_with_long = Set the compile time in the Beacon DLL Content.

#### 8) pe_set_compile_time_with_string = Set the compile time in the Beacon DLL Content.

#### 9) pe_set_export_name = Set the export name in the Beacon DLL Content.

#### 10) pe_set_long = Places a long value at a specified location.

#### 11) pe_set_short = Places a short value at a specified location.

#### 12) pe_set_string = Places a string value at a specified location.

#### 13) pe_set_stringz = Places a string value at a specified location and adds a zero terminator.

#### 14) pe_set_value_at = Sets a long value based on the location resolved by a name from the PE Map (see pedump).

#### 15) pe_stomp = Set a string to null characters. Start at a specified location and sets all characters to null until a null string terminator is reached.

#### 16) pe_update_checksum = Update the checksum in the Beacon DLL Content.

# Using User Defined Reflective DLL Loaders

## Create/Compile your Reflective Loaders

### The User Defined Reflective Loader (UDRL) Kit is the source code for the UDRL example. Go to Help -> Arsenal and download the UDRL Kit (your license key is required).

### The following is the Cobalt Strike process for prepping beacons:

 - The BEACON_RDLL_SIZE hook is called when preparing beacons.

  - This gives the user a chance to indicate that more than 5 KB space will be required for their reflective loader.
 
  - Users can use beacons with space reserved for a reflective loader up to 100 KB
 
  - When overriding available reflective loader space in the beacons, the beacons will be much larger. In fact, they will be too large for standard artifacts provided by Cobalt Strike. Users will need to update their process to use customized artifacts with larger reserved space for the larger beacons.

  - 

