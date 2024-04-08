# Format API

### The format API is used to build large or repeating output.

### Allocate memory to format complex or large output.

 - void BeaconFormatAlloc (formatp * obj, int maxsz)

### Append data to this format object.

 - void BeaconFormatAppend (formatp * obj, char * data, int len)

### Free the format object.

 - void BeaconFormatFree (formatp * obj)

### Append a 4b integer (big endian) to this object.

 - void BeaconFormatInt (formatp * obj, int val)

### Append a formatted string to this object.

 - void BeaconFormatPrintf (formatp * obj, char * fmt, ...)

### Resets the format object to its default state (prior to re-use).

 - void BeaconFormatReset (formatp * obj)

### Extract formatted data into a single string. Populate the passed in size variable with the length of this string. These parameters are suitable for use with the BeaconOutput function.

 - char * BeaconFormatToString (formatp * obj, int * size)
