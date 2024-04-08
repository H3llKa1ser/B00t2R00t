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
