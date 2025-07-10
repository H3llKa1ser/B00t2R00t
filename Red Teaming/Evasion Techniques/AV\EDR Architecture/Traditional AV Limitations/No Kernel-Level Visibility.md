# No Kernel-Level Visibility

Most consumer AV products do not deploy kernel-mode drivers for deep inspection:

1) No view of internal kernel objects or kernel callbacks

2) Cannot intercept syscalls at the KERNEL level

3) Limited ability to detect spoofed PPIDs, token manipulation, or stealth injections

### Evasion Tip: Use techniques like Early Bird injection or APC queuing that trigger before userland AV can inspect.
