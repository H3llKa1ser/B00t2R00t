# Detection Workflow Example

## Real-Time Detection Example Flow:

1) Attacker uses VirtualAllocEx + WriteProcessMemory + CreateRemoteThread.

2) Sensor hooked API calls trigger.

3) EDR flags the action and blocks the thread before payload executes.

## Post-Event Detection Example Flow:

1) Payload runs via rundll32 calling a custom script.

2) Execution appears legitimate at runtime.

3) Cloud analytics detect unusual command-line behavior 5 minutes later.

4) Alert is triggered, but execution already occurred.
