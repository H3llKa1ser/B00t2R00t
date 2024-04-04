# Malleable Command and Control (C2)

### Beacon's HTTP indicators are controlled by a Malleable Command and Control (Malleable C2) profile. A Malleable C2 profile is a simple program that specifies how to transform data and store it in a transaction. The same profile that transforms and stores data, interpreted backwards, also extracts and recovers data from a transaction.

### To use a custom profile, you must start a Cobalt Strike team server and specify your profile at that time.

#### ./teamserver [external IP] [password] [/path/to/my.profile]

### You may only load one profile per Cobalt Strike instance.

## Viewing the Loaded Profile

### To view the C2 profile that was loaded when the TeamServer was started select Help \ Malleable C2 Profile on the menu. This displays the profile for the currently selected TeamServer when multiple TeamServers are connected. The dialog is read-only.

### To close the dialog use the 'x' in the upper right corner of the dialog.

