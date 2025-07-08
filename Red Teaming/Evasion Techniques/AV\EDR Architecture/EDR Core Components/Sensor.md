# Sensor

## Definition:

The sensor is the lightweight software component installed on the endpoint that collects telemetry and monitors behavior in real-time.

## Responsibilities:

1) Hooks API calls and system functions.

2) Captures process creation, file access, registry changes, memory injections, etc.

3) Collects logs and sends data to backend/cloud.

## Features:

1) May run in both user and kernel mode.

2) Often built for stealth and resilience.

3) Typically the first point of contact for attackers.

## Evasion Considerations:

1) Target of DLL unhooking and API redirection.

2) Use of syscall-level evasion to bypass sensor logic.
