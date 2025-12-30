obj-m +=reverse-shell.o

all:
            make -C /lib/modules/$(uname -r)/build M=$(PWD) modules

clean:
            make -C /lib/modules/$(uname -r)/build M=$(PWD) clean
