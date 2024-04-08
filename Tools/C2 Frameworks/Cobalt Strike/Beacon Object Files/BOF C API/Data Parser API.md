# Data Parser API

### The Data Parser API extracts arguments packed with Aggressor Script's &bof_pack function.

### Extract a length-prefixed binary blob. The size argument may be NULL. If an address is provided, the size is populated with the number-of-bytes extracted.

 - char * BeaconDataExtract (datap * parser, int * size)

### Extract a 4b integer

 - int BeaconDataInt (datap * parser)

### Get the amount of data left to parse.

 - int BeaconDataLength (datap * parser)

### Prepare a data parser to extract arguments from the specified buffer.

 - void BeaconDataParse (datap * parser, char * buffer, int size)

### Extract a 2b integer.

 - short BeaconDataShort (datap * parser)
