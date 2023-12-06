## Example:

### 1: /usr/local/bin/example-so

### 2: strace /usr/local/bin/example-so 2>&1 | grep -iE "open|access|no such file"

### 3: Create the directory that the file tried to load the shared object

### 4: Compile code into a shared object (the program that spawns bash shell). 

### Command: gcc -shared -fPIC -o /path/to/shared.so /path/to/file.c

### 5: Execute example-so.
