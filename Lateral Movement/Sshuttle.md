# Only works on Linux

## Author: https://github.com/sshuttle/sshuttle

### Base command to connect:

 - sshuttle -r USER@IP subnet

 - sshuttle -r USER@IP TARGET_IP (We need the user password to run this)

### Essentially, it connects us via ssh to a machine, then the machine is used as a jump box to connect to our target IP

#### -N = Attempts to determine a subnet automatically based on the target's own routing table.

### Key based authentication

 - sshuttle -r USER@IP --ssh-cmd "ssh -i KEY" subnet

#### -x IP = Excludes compromised target from subnet range so that sshuttle won't crash.

