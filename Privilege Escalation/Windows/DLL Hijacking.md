# DLL Hijacking

## Steps:

#### 1: Find a service that when it is executed, searches for a DLL at a directory we have access to overwrite

#### 2: Create the DLL payload in C by either adding a user to administrators group or a reverse shell.

#### 3: Compile the C program to DLL (-shared)

#### 4: Copy file to target at the target directory

#### 5: Restart dllsvc
