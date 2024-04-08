# Output API

### The Output API returns output to Cobalt Strike.

### Format and present output to the Beacon operator.

 - void BeaconPrintf (int type, char * fmt, ...)

### Send output to the Beacon operator

 - void BeaconOutput (int type, char * data, int len)

### Each of these functions accepts a type argument. This type determines how Cobalt Strike will process the output and what it will present the output as. The types are:

#### 1) CALLBACK_OUTPUT is generic output. Cobalt Strike will convert this output to UTF-16 (internally) using the target's default character set.

#### 2) CALLBACK_OUTPUT_OEM is generic output. Cobalt Strike will convert this output to UTF-16 (internally) using the target's OEM character set. You probably won't need this, unless you're dealing with output from cmd.exe.

#### 3) CALLBACK_ERROR is a generic error message.

#### 4) CALLBACK_OUTPUT_UTF8 is generic output. Cobalt Strike will convert this output to UTF16 (internally) from UTF-8.
