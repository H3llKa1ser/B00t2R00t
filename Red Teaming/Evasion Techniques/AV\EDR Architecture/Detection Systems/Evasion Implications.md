# Evasion Implications

To bypass both detection strategies:

# Against Real-Time:

1) Avoid known API call sequences.

2) Use direct syscalls (syswhispers, hellsgate).

3) Delay payload with sleep/dormant phases.

# Against Post-Event:

1) Avoid creating permanent artifacts (files, registry, services).

2) Clean up after execution (registry keys, temp files).

3) Use native Windows binaries (LOLBAS).
