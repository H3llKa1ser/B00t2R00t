# HTTP Beacons

### Allows you to specify attributes for general attributes for the http(s) beacons.

### The default beacon library can subsequently be overridden on UI Dialogs and Aggressor Commands that generate beacons as needed.

http-beacon {
set library "winhttp";
}
http-beacon "variant-x" {
set library "wininet";
}

### The settings are:

#### 1) library = The library attribute allows user to specify the default library used by the generated beacons used by the profile. The library defaults to "wininet", which is the only type of beacon prior to version 4.9. The library value can be "wininet" or "winhttp".



