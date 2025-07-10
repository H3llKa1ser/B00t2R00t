# Event Tracing for Windows (ETW)

## Overview:

ETW is a high-performance tracing system built into Windows that allows the collection of system and application events in real time.

## Use in EDRs:

EDRs and other telemetry-based tools subscribe to various ETW providers to get detailed telemetry without active interference in process execution.

## Key Providers:

1) Sysmon (Event ID-based tracking)

2) Microsoft-Windows-Threat-Intelligence

3) Microsoft-Windows-Kernel-Process

4) Microsoft-Windows-Kernel-Image

## Common Events Tracked:

1) Process creation and termination

2) Thread start/stop

3) DLL load/unload

4) Registry modifications

5) Network connections

## Advantages:

Non-invasive (doesn't require hooks or inline patching)

Harder to detect or block from userland

Highly scalable and customizable

## Bypass Techniques:

1) Blocking ETW function (EtwEventWrite, EtwNotificationRegister)

2) Overwriting ETW registration in userland

3) Using unmonitored syscalls

4) Removing ETW providers via native APIs or tampering

