# BOF Development

### Open your preferred text editor and start writing a C program. (Check programs folder for examples)

## Download beacon.h

## Compile with Visual Studio

cl.exe /c /GS- hello.c /Fohello.o

## Compile with x86 MinGW

i686-w64-mingw32-gcc -c hello.c -o hello.o

## Compile with x64 MinGW

x86_64-w64-mingw32-gcc -c hello.c -o hello.o

### The commands above produce a hello.o file. Use inline-execute in Beacon to run the BOF.

beacon> inline-execute /path/to/hello.o these are arguments

### beacon.h contains definitions for several internal Beacon APIs. The function go is similar to main in any other C program. It's the function that's called by inline-execute and arguments are passed to it. BeaconOutput is an internal Beacon API to send output to the operator. Not much to it.


