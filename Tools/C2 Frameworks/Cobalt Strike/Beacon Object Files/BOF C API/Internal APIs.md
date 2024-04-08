# Internal APIs

## The following functions manipulate the token used in the current Beacon context:

### Apply the specified token as Beacon's current thread token. This will report the new token to the user too. Returns TRUE if successful. FALSE is not.

 - BOOL BeaconUseToken (HANDLE token)

### Drop the current thread token. Use this over direct calls to RevertToSelf. This function cleans up other state information about the token.

 - void BeaconRevertToken ()

### Returns TRUE if Beacon is in a high-integrity context.

 - BOOL BeaconIsAdmIn ()

## The following functions provide some access to Beacon's process injection capability:

### Populate the specified buffer with the x86 or x64 spawnto value configured for this Beacon session.

 - void BeaconGetSpawnTo (BOOL x86, char * buffer, int length)

### This function spawns a temporary process accounting for ppid, spawnto, and blockdlls options. Grab the handle from PROCESS_INFORMATION to inject into or manipulate this process. Returns TRUE if successful.

 - BOOL BeaconSpawnTemporaryProcess (BOOL x86, BOOL ignoreToken, STARTUPINFO * sInfo, PROCESS_INFORMATION * pInfo)

### This function will inject the specified payload into an existing process. Use payload_offset to specify the offset within the payload to begin execution. The arg value is for arguments. arg may be NULL.

 - void BeaconInjectProcess (HANDLE hProc, int pid, char * payload, int payload_len, int payload_offset, char * arg, int arg_len)

### This function injects the specified payload into a temporary process that your BOF opted to launch. Use payload_offset to specify the offset within the payload to begin execution. The arg value is for arguments. arg may be NULL.

 - void BeaconInjectTemporaryProcess (PROCESS_INFORMATION * pInfo, char * payload, int payload_len, int payload_offset, char * arg, int arg_len)

### This function cleans up some handles that are often forgotten about. Call this when you're done interacting with the handles for a process. You don't need to wait for the process to exit or finish.

 - void BeaconCleanupProcess (PROCESS_INFORMATION * pInfo)

## The following functions are used to access stored items in Beacon Data Store:

### Returns a pointer to the specific item. If there is no entry at that index, the function returns NULL.

 - PDATA_STORE_OBJECT BeaconDataStoreGetItem (size_t index)

### This function obfuscates a specific item in Beacon Data Store.

 - void BeaconDataStoreProtectItem (size_t index)

### This function un-obfuscates a specific item in Beacon Data Store.

 - void BeaconDataStoreUnprotectItem (size_t index)

### Return the maximum size of Beacon Data Store.

 - size_t BeaconDataStoreMaxEntries ()

## The following function is a utility function:

### Convert the src string to a UTF16-LE wide-character string, using the target's default encoding. max is the size (in bytes!) of the destination buffer.

 - BOOL toWideChar (char * src, wchar_t * dst, int max)

### This function returns information about beacon such as the beacon address, sections to mask, heap records to mask, the mask, sleep mask address and sleep mask size information.

 - void BeaconInformation (BEACON_INFO * info);

## The following functions provide access to Beacon's key value store:

### This function adds a memory address to an internal key value store to allow the ability to retrieve this value using the key in a subsequent BOF execution.

 - BOOL BeaconAddValue (const char * key, void * ptr);

### This function retrieves the memory address that is associated with the key from the internal key value store. If the key is not found then NULL is returned.

 - void * BeaconGetValue (const char * key);

### This function removes the key from the internal key value store. This will not do any memory clean up of the memory address and a finial execution of a BOF should do the necessary clean up in order to prevent memory leaks.

 - BOOL BeaconRemoveValue (const char * key);

### The following function retrieves the custom data buffer from Beacon User Data.

 - char* BeaconGetCustomUserData ()

### When a User Defined Reflective Loader provides Beacon User Data (BUD) during the loading process, then this function will return a pointer to the custom buffer array associated with the BUD. The size of this buffer array is fixed at 32 bytes, as defined in the USER_DATA structure. A valid memory pointer is always returned. If no BUD is provided by the User Defined Reflective Loader, then the pointer is to the default buffer array with all 32 values set to zero.

