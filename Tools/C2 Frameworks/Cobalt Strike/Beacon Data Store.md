# Beacon Data Store

### Beacon Data Store enables an operator to store Beacon Object Files (BOFs) and .NET assemblies in Beacon's memory. These stored items can subsequently be executed multiple times without resending the item. The Cobalt Strike client automatically detects whether an object to be executed is already stored in the data store. The stored entries are masked by default, and the item is unmasked only when it is used.

### In addition to Beacon Object Files and .NET assemblies, it is possible to store generic files in the data store, and these files can be accessed from within BOFs.

### The default size of the data store is 16 entries, but you can modify this size by configuring the data_store_size option within the stage block of a C2 profile.

### The data-store load [bof|dotnet|file] <name> [file path] command stores an item in the store. If the name argument is not provided, then the file name is used.

### The data-store unload [index] removes the stored item.

### The data-store list lists the items currently available in the data store.
