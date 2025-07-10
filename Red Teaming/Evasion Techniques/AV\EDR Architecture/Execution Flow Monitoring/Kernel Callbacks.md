# Kernel Callbacks

## Definition:

Kernel-mode callbacks are registered via kernel APIs and are used to observe system-level events.

## Common Callbacks Used by EDRs:

1) PsSetCreateProcessNotifyRoutine: process creation

2) PsSetLoadImageNotifyRoutine: image load tracking

3) ObRegisterCallbacks: handle/object access (e.g., opening lsass)

4) CmRegisterCallbackEx: registry access

## How EDRs Use Callbacks:

These callbacks allow real-time detection and access control before the system completes the requested operation.

## Bypass and Evasion Techniques:

Process ghosting/hollowing to avoid detection

Handle duplication to bypass ObRegisterCallbacks

Tampering with kernel objects

Driver-level manipulation of callback tables (requires kernel access)
