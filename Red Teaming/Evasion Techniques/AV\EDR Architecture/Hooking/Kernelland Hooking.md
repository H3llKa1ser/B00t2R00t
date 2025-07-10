# Kernelland Hooking

## Definition:

Kernelland hooking involves monitoring or modifying behavior at the kernel level using drivers, typically implemented via kernel-mode callbacks or by modifying system structures like the SSDT (System Service Dispatch Table).

## Techniques:

1) SSDT Hooking: Intercepting system calls by modifying the SSDT to point to custom handlers.

2) Callback Registration: Using legitimate kernel APIs to register callbacks:

 - PsSetCreateProcessNotifyRoutine

 - PsSetLoadImageNotifyRoutine

 - CmRegisterCallback

3) Object Callbacks: Intercepting object operations with ObRegisterCallbacks.

## Advantages:

1) Cannot be bypassed with simple userland techniques.

2) Deeper visibility into process/thread/image/registry activity.

3) Detects unusual kernel behavior or stealthy rootkits.

## Limitations:

1) Requires signed kernel driver.

2) More difficult to deploy and maintain.

3) Vulnerable to advanced kernel-mode rootkits and driver exploitation.
